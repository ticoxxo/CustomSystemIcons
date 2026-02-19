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
    @Bindable var vmIcon: IconModel
    @State var helperImage: ImageConverter = ImageConverter()
    @State var imageTypes: ImageType = .jpeg
    var addMode: Bool
    @State var showAlert: Bool = false
    @State var messageAlert: String = ""
    @State private var animateIcon = false
    
    var body: some View {
        Form {
            Section(header: Text("GroupBox.Title.Icon")) {
                IconView(vmIcon: vmIcon, editable: false)
                    .overlay( alignment: .bottomTrailing) {
                        Image(systemName: "pencil.circle")
                            .resizable()
                            .foregroundColor(MyColor.skyblue.value)
                            .frame(maxWidth: min(horizontalPadding, verticalPadding) / 8, maxHeight: min(horizontalPadding, verticalPadding) / 8)
                    }
                    .onTapGesture {
                        coordinator.push(page: .EditIcon(vmIcon: vmIcon))
                    }
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
        .transition(.scale)
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
        .toolbar {
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                
                Button {
                    coordinator.push(page: .ShareView(vmIcon: vmIcon))
                } label: {
                    Label("Label.Share", systemImage: "square.and.arrow.up.fill")
                }
                
                if addMode {
                    Button {
                        modelContext.insert(vmIcon)
                        messageAlert = NSLocalizedString("Alert.Added", comment: "")
                        showAlert = true
                    } label: {
                        Label("Button.Add",systemImage: "plus.square.fill" )
                    }
                    .customAccessibility(label: "Button.Add.Accessibility", hint: "Button.Add.Accessibility.Hint")
                    
                }
                else {
                    Button {
                        do {
                            try modelContext.save()
                            messageAlert = "Saved"
                            showAlert = true
                        } catch {
                            messageAlert = "Error updating model"
                            showAlert = true
                        }
                        
                    } label: {
                        Label("Button.Save",systemImage: "line.3.horizontal.button.angledtop.vertical.right")
                    }
                    .customAccessibility(label: "Button.Save.Accessibility", hint: "Button.Save.Accessibility.Hint")
                    
                }
                
            }
            
            
            ToolbarItemGroup(placement: .topBarLeading) {
                GoBackButton()
            }
        }
        .navigationBarBackButtonHidden(true)
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
