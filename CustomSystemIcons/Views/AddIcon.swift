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
            GroupBox(label: Text("GroupBox.Title.Icon")) {
                IconView(vmIcon: vmIcon, bWidth: min(horizontalPadding, verticalPadding) / 2 , bHeight: min(horizontalPadding, verticalPadding) / 2, editable: false)
                    .overlay( alignment: .bottomTrailing) {
                        Image(systemName: "pencil.circle")
                            .resizable()
                            .customAccessibility(label: "Label.EditIcon.Accessibility", hint: "Label.EditIcon.Accessibility.Hint", isButton: true)
                            .foregroundColor(MyColor.skyblue.value)
                            .frame(maxWidth: min(horizontalPadding, verticalPadding) / 8, maxHeight: min(horizontalPadding, verticalPadding) / 8)
                    }
                    .onTapGesture {
                        coordinator.push(page: .EditIcon(vmIcon: vmIcon))
                    }
            }
            .customAccessibility(label: "GroupBox.Title.Icon.Accesibility", hint: "GroupBox.Title.Icon.Accesibility.Hint")
            
            GroupBox(label: Text("GroupBox.Title.Detail")) {
                TextField("TextField.Title", text: $vmIcon.title)
                    .customAccessibility(label: "TextField.Title.Accesibility", hint: "TextField.Title.Accesibility.Hint")
                    .textFieldStyle(.roundedBorder)
                    
            }
            .customAccessibility(label: "GroupBox.Title.Detail.Accesibility", hint: "GroupBox.Title.Detail.Accesibility.Hint")
            
            GroupBox(label: Text("GroupBox.Title.Share")) {
                VStack {
                    Picker("Picker.ImageType", selection: $imageTypes) {
                        ForEach(ImageType.allCases) { types in
                            Text(types.rawValue.capitalized).tag(types)
                        }
                    }
                    .customAccessibility(label: "Picker.ImageType.Accesibility", hint: "Picker.ImageType.Accesibility.Hint")
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .customAccessibility(label: "Group.Title.Share.Accesibility", hint: "Group.Title.Share.Accesibility.Hint")
            
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
            
        }
        .offset(x: animateIcon ? 0 : -UIScreen.main.bounds.width)
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
            
            ToolbarItem(placement: .topBarTrailing) {
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


#Preview {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @State var vmIcon = IconModel()
    NavigationStack(path: $coordinator.path) {
        coordinator.build(page: .AddIcon(vmIcon: vmIcon, addMode: false))
            .navigationDestination(for: AppPage.self) { page in
                coordinator.build(page: page)
            }
    }
    .environment(\.coordinator, coordinator)
}


