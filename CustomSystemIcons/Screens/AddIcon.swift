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
    @State var helperImage: ImageConverter = ImageConverter()
    @State var imageTypes: ImageType = .jpeg
    var addMode: Bool
    @State var showAlert: Bool = false
    @State var messageAlert: String = ""
    @State private var isEditable: Bool = false
    @State private var animateIcon = false
    @State private var showUnsavedChangesDialog = false
    @State private var isSaving = false
    @ScaledMetric private var iconSize: CGFloat = 50
    @ScaledMetric private var screenSize: CGFloat = 500
    
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
        !addMode && modelContext.hasChanges
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
                IconView(vmIcon: vmIcon,
                         editable: isEditable)
                .padding()
            }
            Form {
                
                Section(header: Text("GroupBox.Title.Detail")) {
                    TextField("TextField.Title", text: $vmIcon.title)
                        .onChange(of: vmIcon.title) { _, newValue in
                            vmIcon.title = String(newValue.prefix(12))
                            }
                        .textFieldStyle(.automatic)
                    Grid(alignment: .leading) {
                                            GridRow {
                                                Text("Label.IsMovable")
                                                HStack {
                                                    Spacer()
                                                    Toggle("Editable", isOn: $isEditable)
                                                        .labelsHidden()
                                                }
                                            }
                                            GridRow {
                                                Text("Choose an Icon")
                                                HStack(spacing: 15) {
                                                    Spacer()
                                                    Button(action: addIcon) {
                                                        Image(systemName: "xmark.triangle.circle.square.fill")
                                                    }
                                                    .customAccessibility(label: "Label.AddIcon.Accessibility", hint: "Click to add a new icon")
                                                    .buttonStyle(.borderless)
                                                    .disabled(vmIcon.icons.count > 15)
                                                    
                                                    Button(action: addText) {
                                                        Image(systemName: "character.square.fill")
                                                    }
                                                    .customAccessibility(label: "Label.AddIcon.Accessibility", hint: "Click to add a new icon")
                                                    .buttonStyle(.borderless)
                                                    .disabled(vmIcon.icons.count > 15)
                                                    
                                                }
                                            }
                                        }

                }
                Section {
                    unsavedChangesStatus
                }
                ColorSection(vmIcon: vmIcon)
                TextPropertiesSection(vmIcon: vmIcon)
                ShapeSection(vmIcon: vmIcon)
                OrientationSection(vmIcon: vmIcon)
                PositionSection(vmIcon: vmIcon)
                DistortionSection(vmIcon: vmIcon)
                BorderSection(vmIcon: vmIcon)
                ShadowSection(vmIcon: vmIcon)
                ManualPositionSection(vmIcon: vmIcon)
                
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
                    coordinator.push(page: .ShareView(vmIcon: vmIcon))
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
        modelContext.rollback()
        modelContext.processPendingChanges()
        coordinator.pop()
    }

    private func addIconAndGoBack() {
        if vmIcon.title.isEmpty {
            vmIcon.title = "Icon \(vmIcon.shape.selectedPath.value)"
        }
        modelContext.insert(vmIcon)
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
            /*
            if vmIcon.title.isEmpty {
                vmIcon.title = "Icon \(vmIcon.shape.selectedPath.value)"
            }
             */
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
        vmIcon.addText()
    }

    private func addIcon() {
        vmIcon.addIcon()
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
