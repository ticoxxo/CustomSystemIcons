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
    @Environment(\.modelContext) var modelContext
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Bindable var vmIcon: IconModel
    @State var helperImage: ImageConverter = ImageConverter()
    @State var imageTypes: ImageType = .jpeg
    var addMode: Bool
    @State var showAlert: Bool = false
    @State var messageAlert: String = ""
    @State private var animateIcon = false
    @State private var showUnsavedChangesDialog = false
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
    
    var body: some View {
        Form {
            Section(header: Text("GroupBox.Title.Icon")) {
                IconView(vmIcon: vmIcon, editable: false)
                    .overlay( alignment: .bottomTrailing) {
                        Button {
                            coordinator.push(page: .EditIcon(vmIcon: vmIcon))
                        } label: {
                            Image(systemName: "applepencil.and.scribble")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(MyColor.skyblue.value)
                                .frame(width: iconContainerSize, height: iconContainerSize)
                        }
                        .buttonStyle(.glass)
                    }
                    .padding()
            }
            
            
            Section(header: Text("GroupBox.Title.Detail")) {
                TextField("TextField.Title", text: $vmIcon.title)
                    .onChange(of: vmIcon.title) { _, newValue in
                        vmIcon.title = String(newValue.prefix(12))
                        }
                    .textFieldStyle(.roundedBorder)
            }
            
            
        }
        .offset(x: animateIcon ? 0 : -horizontalPadding)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                animateIcon = true
            }
        }
        .navigationTitle(addMode ? "Add Icon" : "Edit Icon")
        .alert(messageAlert ,isPresented: $showAlert) {
            
            Button {
                coordinator.toRoot()
            } label: {
                Label("Button.OK.Accessibility", systemImage: "trash")
            }
            .customAccessibility(label: "Button.OK.Accessibility", hint: "Button.OK.Accessibility.Hint")
        }
        .confirmationDialog("Unsaved changes", isPresented: $showUnsavedChangesDialog) {
            Button("Save") {
                if saveIcon(showFeedback: false) {
                    coordinator.pop()
                }
            }
            Button("Cancel edit", role: .destructive) {
                discardChangesAndGoBack()
            }
            Button("Keep editing", role: .cancel) { }
        } message: {
            Text("You have unsaved changes. Save before leaving?")
        }
        .toolbar {
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                
                GlassEffectContainer(spacing: 20.0) {
                    HStack(spacing: 20.0) {
                        Button {
                            coordinator.push(page: .ShareView(vmIcon: vmIcon))
                        } label: {
                            Label("Label.Share", systemImage: "square.and.arrow.up.fill")
                        }
                        .buttonStyle(.glass)
                        
                        buttonMode
                    }
                }
                
            }
            
            
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    handleGoBack()
                } label: {
                    Label("Label.GoBack", systemImage: "arrow.left")
                }
                .customAccessibility(label: "Button.Back.Accessibility", hint: "Button.Back.Accessibility.Hint")
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
            saveButton
        }
    }
    
    @ViewBuilder
    var addButton: some View {
        Button {
            if vmIcon.title.isEmpty {
                vmIcon.title = "Icon \(vmIcon.shape.selectedPath.value)"
            }
            modelContext.insert(vmIcon)
            messageAlert = NSLocalizedString("Alert.Added", comment: "")
            showAlert = true
        } label: {
            Label("Button.Add",systemImage: "externaldrive.fill.badge.plus" )
        }
        .customAccessibility(label: "Button.Add.Accessibility", hint: "Button.Add.Accessibility.Hint")
        
    }
    @ViewBuilder
    var saveButton: some View {
        Button {
            _ = saveIcon(showFeedback: true)
        } label: {
            Label("Button.Save",systemImage: "pencil.and.list.clipboard")
        }
        .customAccessibility(label: "Button.Save.Accessibility", hint: "Button.Save.Accessibility.Hint")
       
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
        coordinator.pop()
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
        do {
            /*
            if vmIcon.title.isEmpty {
                vmIcon.title = "Icon \(vmIcon.shape.selectedPath.value)"
            }
             */
            try modelContext.save()
            if showFeedback {
                messageAlert = "Saved"
                showAlert = true
            }
            return true
        } catch {
            messageAlert = "Error updating model"
            showAlert = true
            return false
        }
    }
}


#Preview("Add mode false") {
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
    .environment(\.coordinator, coordinator)
}

#Preview("Add mode true") {
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
    .environment(\.coordinator, coordinator)
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
