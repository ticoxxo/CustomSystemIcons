//
//  AddIcon.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//

import SwiftUI
import SFSafeSymbols
import SwiftData


struct AddIcon: View {
    @Environment(\.coordinator) var coordinator
    @Environment(\.modelContext) private var modelContext
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Bindable var vmIcon: IconModel
    @State private var draftIcon: IconModel
    @State private var baselineSnapshot: IconSnapshot
    @State var helperImage: ImageConverter = ImageConverter()
    @State var imageTypes: ImageType = .jpeg
    var addMode: Bool
    @State var showAlert: Bool = false
    @State var messageAlert: String = ""
    @State private var isEditable: Bool = true
    @State private var animateIcon = false
    @State private var showUnsavedChangesDialog = false
    @State private var isSaving = false
    @ScaledMetric private var iconSize: CGFloat = 50
    @ScaledMetric private var screenSize: CGFloat = 500

    init(vmIcon: IconModel, addMode: Bool) {
        self._vmIcon = Bindable(wrappedValue: vmIcon)
        self.addMode = addMode
        let draft = Self.makeDraft(from: vmIcon)
        _draftIcon = State(initialValue: draft)
        _baselineSnapshot = State(initialValue: IconSnapshot(icon: draft))
    }
    
    private var iconContainerSize: CGFloat {
        switch (horizontalSizeClass, verticalSizeClass) {
        case (.compact?, .regular?):
            return 60
        case (.regular?, .regular?):
            return 200
        case (.regular?, .compact?):
            return 260
        default:
            return 240
        }
    }
    
    private var hasUnsavedChanges: Bool {
        !addMode && IconSnapshot(icon: draftIcon) != baselineSnapshot
    }

    @ViewBuilder
    private var unsavedChangesStatus: some View {
        if addMode {
            EmptyView()
        } else {
            HStack(spacing: 8) {
                Image(systemName: hasUnsavedChanges ? "exclamationmark.triangle.fill" : "checkmark.circle.fill")
                Text(hasUnsavedChanges ? "Unsaved changes" : "All changes saved")
            }
            .font(.footnote)
            .foregroundStyle(hasUnsavedChanges ? .orange : .green)
            .accessibilityLabel(hasUnsavedChanges ? "Unsaved changes" : "All changes saved")
        }
    }
    
    var body: some View {
        
        VStack {
            VStack {
                unsavedChangesStatus
                IconView(vmIcon: draftIcon,
                         editable: isEditable)
                .padding()
            }
            Form {
                
                Section(header: Text("GroupBox.Title.Detail")) {
                    TextField("TextField.Title", text: $draftIcon.title)
                        .onChange(of: draftIcon.title) { _, newValue in
                            draftIcon.title = String(newValue.prefix(12))
                            }
                        .textFieldStyle(.automatic)
                    Grid(alignment: .leading) {
                                            
                                            GridRow {
                                                Text("Choose an Icon")
                                                HStack(spacing: 15) {
                                                    Spacer()
                                                    Button(action: addIcon) {
                                                        Image(systemName: "xmark.triangle.circle.square.fill")
                                                    }
                                                    .customAccessibility(label: "Label.AddIcon.Accessibility", hint: "Click to add a new icon")
                                                    .buttonStyle(.borderless)
                                                    .disabled(draftIcon.icons.count > 15)
                                                    
                                                    Button(action: addText) {
                                                        Image(systemName: "character.square.fill")
                                                    }
                                                    .customAccessibility(label: "Label.AddIcon.Accessibility", hint: "Click to add a new icon")
                                                    .buttonStyle(.borderless)
                                                    .disabled(draftIcon.icons.count > 15)
                                                    
                                                }
                                            }
                                        }

                }
                
                ColorSection(vmIcon: draftIcon)
                TextPropertiesSection(vmIcon: draftIcon)
                ShapeSection(vmIcon: draftIcon)
                OrientationSection(vmIcon: draftIcon)
                PositionSection(vmIcon: draftIcon)
                DistortionSection(vmIcon: draftIcon)
                BorderSection(vmIcon: draftIcon)
                ShadowSection(vmIcon: draftIcon)
                ManualPositionSection(vmIcon: draftIcon)
                
            }
        }
        .offset(x: animateIcon ? 0 : -horizontalPadding)
        .onAppear {
            modelContext.autosaveEnabled = false
            withAnimation(.easeInOut(duration: 1.0)) {
                animateIcon = true
            }
        }
        .onDisappear {
            modelContext.autosaveEnabled = true
        }
        .confirmationDialog("Unsaved changes", isPresented: $showUnsavedChangesDialog) {
            saveButton()
            Button("OK", role: .cancel) {}
            Button("Delete", role: .destructive, action: discardChangesAndGoBack)
        } message: {
            Text("Save changes or press X button")
        }
        .toolbar {
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                
                Button {
                    coordinator.push(page: .ShareView(vmIcon: draftIcon))
                } label: {
                    Label("Label.Share", systemImage: "square.and.arrow.up.fill")
                }
                
                buttonMode
                
            }
            
            
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    handleGoBack()
                } label: {
                    Label("Label.GoBack", systemImage: "arrow.left")
                }
                .foregroundColor(MyColor.skyblue.value)
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    var buttonMode: some View {
        if addMode {
            addButton
        } else {
            saveButton()
                .disabled(!hasUnsavedChanges)
        }
    }
    
    @ViewBuilder
    var addButton: some View {
        Button {
            addIconAndGoBack()
        } label: {
            Label("Button.Add",systemImage: "externaldrive.fill.badge.plus" )
        }
        .customAccessibility(label: "Button.Add.Accessibility", hint: "Button.Add.Accessibility.Hint")
        .buttonStyle(.glass)
    }
    
    private func saveButton() -> some View {
        Button {
            applyDraftChanges()
            do {
                try modelContext.save()
                modelContext.processPendingChanges()
                coordinator.pop()
            } catch {
                messageAlert = "Error saving model: \(error.localizedDescription)"
                showAlert = true
            }
        } label: {
            Label("Button.Save",systemImage: "pencil.and.list.clipboard")
        }
    }

    private func handleGoBack() {
        if hasUnsavedChanges {
            showUnsavedChangesDialog = true
        } else {
            coordinator.pop()
        }
    }

    private func discardChangesAndGoBack() {
        coordinator.pop()
    }

    private func addIconAndGoBack() {
        if draftIcon.title.isEmpty {
            draftIcon.title = "Icon \(draftIcon.shape.selectedPath.value)"
        }
        modelContext.insert(draftIcon)
        isSaving = true
        defer {
            isSaving = false
        }
        do {
            try modelContext.save()
            modelContext.processPendingChanges()
            coordinator.pop()
        } catch {
            messageAlert = "Error saving model: \(error.localizedDescription)"
            showAlert = true
        }
    }

    /// Saves the current icon model to the SwiftData context.
    ///
    /// - Parameter showFeedback: When `true`, presents a success or error alert after attempting to save.
    /// - Returns: `true` if the save succeeds; otherwise `false`.
    ///
    /// Example:
    /// ```swift
    /// if saveIcon(showFeedback: true) {
    ///     coordinator.pop()
    /// }
    /// ```
    @discardableResult
    private func saveIcon(showFeedback: Bool) -> Bool {
        isSaving = true
        defer {
            isSaving = false
        }
        do {
            applyDraftChanges()
            try modelContext.save()
            modelContext.processPendingChanges()
            return true
        } catch {
            messageAlert = "Error updating model: \(error.localizedDescription)"
            showAlert = true
            return false
        }
    }
    
    private func addText() {
        draftIcon.addText()
    }

    private func addIcon() {
        draftIcon.addIcon()
    }

    private func applyDraftChanges() {
        guard !addMode else { return }
        Self.applyDraft(from: draftIcon, to: vmIcon)
    }

    private static func makeDraft(from icon: IconModel) -> IconModel {
        let backgroundImage = BackgroundImageModel(
            backgroundImage: icon.backgroundImage.backgroundImage,
            zoom: icon.backgroundImage.zoom,
            orientation: icon.backgroundImage.orientation,
            dragging: false,
            positionX: icon.backgroundImage.positionX,
            positionY: icon.backgroundImage.positionY
        )
        let icons = icon.icons.map { cloneIconChild($0) }
        let draft = IconModel(
            title: icon.title,
            shape: icon.shape,
            borderWidth: icon.borderWidth,
            backgroundColorComputed: icon.backgroundColorComputed,
            borderColorComputed: icon.borderColorComputed,
            icons: icons,
            creationDate: icon.creationDate,
            isFavorite: icon.isFavorite,
            backgroundImage: backgroundImage,
            shadows: icon.shadows
        )
        draft.id = icon.id
        return draft
    }

    private static func applyDraft(from draft: IconModel, to model: IconModel) {
        model.title = draft.title
        model.shape = draft.shape
        model.borderWidth = draft.borderWidth
        model.backgroundColorComputed = draft.backgroundColorComputed
        model.borderColorComputed = draft.borderColorComputed
        model.creationDate = draft.creationDate
        model.isFavorite = draft.isFavorite
        model.shadows = draft.shadows
        applyBackgroundImage(from: draft.backgroundImage, to: model.backgroundImage)
        model.icons = draft.icons.map { cloneIconChild($0) }
    }

    private static func applyBackgroundImage(from draft: BackgroundImageModel, to model: BackgroundImageModel) {
        model.backgroundImage = draft.backgroundImage
        model.zoom = draft.zoom
        model.orientation = draft.orientation
        model.positionX = draft.positionX
        model.positionY = draft.positionY
        model.cachedUIImage = draft.cachedUIImage
    }

    private static func cloneIconChild(_ child: IconChild) -> IconChild {
        IconChild(
            id: child.id,
            name: child.name,
            frontColorComputed: child.frontColorComputed,
            orientation: child.orientation,
            zoom: child.zoom,
            dragging: false,
            zIndex: child.zIndex,
            borderColorComputed: child.borderColorComputed,
            positionX: child.positionX,
            positionY: child.positionY,
            xDistortion: child.xDistortion,
            yDistortion: child.yDistortion,
            shadows: child.shadows,
            isIcon: child.isIcon,
            textProperties: child.textProperties
        )
    }

    private struct IconSnapshot: Equatable {
        var title: String
        var shape: FiguraSnapshot
        var backgroundColor: ColorComponents
        var borderColor: ColorComponents
        var borderWidth: CGFloat
        var icons: [IconChildSnapshot]
        var creationDate: Date
        var isFavorite: Bool
        var backgroundImage: BackgroundImageSnapshot
        var shadows: ShadowSnapshot

        init(icon: IconModel) {
            self.title = icon.title
            self.shape = FiguraSnapshot(icon.shape)
            self.backgroundColor = icon.backgroundColorComputed
            self.borderColor = icon.borderColorComputed
            self.borderWidth = icon.borderWidth
            self.icons = icon.icons.map { IconChildSnapshot($0) }
            self.creationDate = icon.creationDate
            self.isFavorite = icon.isFavorite
            self.backgroundImage = BackgroundImageSnapshot(icon.backgroundImage)
            self.shadows = ShadowSnapshot(icon.shadows)
        }
    }

    private struct FiguraSnapshot: Equatable {
        var cornerRadio: CGFloat
        var selectedPathValue: String
        var corners: Int
        var insetAmount: CGFloat
        var innerRadiusRatio: CGFloat

        init(_ figura: Figura) {
            self.cornerRadio = figura.cornerRadio
            self.selectedPathValue = figura.selectedPath.value
            self.corners = figura.corners
            self.insetAmount = figura.insetAmount
            self.innerRadiusRatio = figura.innerRadiusRatio
        }
    }

    private struct IconChildSnapshot: Equatable {
        var id: UUID
        var name: String
        var frontColor: ColorComponents
        var orientation: Double
        var zoom: Float
        var zIndex: Double
        var borderColor: ColorComponents
        var positionX: CGFloat
        var positionY: CGFloat
        var xDistortion: CGFloat
        var yDistortion: CGFloat
        var shadows: ShadowSnapshot
        var isIcon: Bool
        var textProperties: TextModel

        init(_ child: IconChild) {
            self.id = child.id
            self.name = child.name
            self.frontColor = child.frontColorComputed
            self.orientation = child.orientation
            self.zoom = child.zoom
            self.zIndex = child.zIndex
            self.borderColor = child.borderColorComputed
            self.positionX = child.positionX
            self.positionY = child.positionY
            self.xDistortion = child.xDistortion
            self.yDistortion = child.yDistortion
            self.shadows = ShadowSnapshot(child.shadows)
            self.isIcon = child.isIcon
            self.textProperties = child.textProperties
        }
    }

    private struct ShadowSnapshot: Equatable {
        var opacity: Double
        var radius: CGFloat
        var shadowX: CGFloat
        var shadowY: CGFloat
        var color: ColorComponents

        init(_ shadow: ShadowModel) {
            self.opacity = shadow.opacity
            self.radius = shadow.radius
            self.shadowX = shadow.shadowX
            self.shadowY = shadow.shadowY
            self.color = shadow.colorComputed
        }
    }

    private struct BackgroundImageSnapshot: Equatable {
        var backgroundImage: Data?
        var zoom: Float
        var orientation: Double
        var positionX: Double
        var positionY: Double

        init(_ model: BackgroundImageModel) {
            self.backgroundImage = model.backgroundImage
            self.zoom = model.zoom
            self.orientation = model.orientation
            self.positionX = model.positionX
            self.positionY = model.positionY
        }
    }
}

#Preview("Edit mode") {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @State var vmIcon = IconModel()
    NavigationStack(path: $coordinator.path) {
        coordinator.build(page: .AddIcon(vmIcon: vmIcon, addMode: false))
            .navigationDestination(for: AppPage.self) { page in
                coordinator.build(page: page)
            }
            .sheet(item: $coordinator.sheet) { sheet in
                coordinator.buildSheet(sheet: sheet)
            }
    }
}


#Preview("Add mode") {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @State var vmIcon = IconModel()
    NavigationStack(path: $coordinator.path) {
        coordinator.build(page: .AddIcon(vmIcon: vmIcon, addMode: true))
            .navigationDestination(for: AppPage.self) { page in
                coordinator.build(page: page)
            }
            .sheet(item: $coordinator.sheet) { sheet in
                coordinator.buildSheet(sheet: sheet)
            }
    }
}
/*
 
 
 
 
 
 
 if !addMode {
     HStack {
         Spacer()
         if imageTypes == .jpeg {
             let uiImagu = helperImage.shareViewAsImage(iconModel: vmIcon)
             let img = Image(uiImage: uiImagu ?? UIImage(systemName: "photo")!)
            
             ShareLink(
                 item: img,
                 preview: SharePreview(String(localized: "Enjoy!"), image: img)
             )
             .customAccessibility(label: "Label.Share.Accessibility", hint: "Label.Share.Accessibility.Hint")
             .buttonStyle(CustomButton(color: MyColor.skyblue.value, width: horizontalPadding ))
         } else {
             let uiImagu =  helperImage.sharePng(iconModel: vmIcon, type: imageTypes)
             let imageVIew = helperImage.shareViewAsImage(iconModel: vmIcon)
             let img = Image(uiImage: imageVIew ?? UIImage(systemName: "photo")!)
             ShareLink(
                     item: uiImagu,
                     preview: SharePreview(String(localized: "Enjoy!"), image: img)
             )
             .customAccessibility(label: "Label.Share.Accessibility", hint: "Label.Share.Accessibility.Hint")
             .buttonStyle(CustomButton(color: MyColor.skyblue.value, width: horizontalPadding))
         }
         Spacer()
     }
     
 }
 */
