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
    
    var body: some View {
        Form {
            GroupBox(String(localized: "Choose an Icon")) {
                IconView(vmIcon: vmIcon, bWidth: 100, bHeight: 100, editable: false)
                    .onTapGesture {
                        coordinator.push(page: .EditIcon(vmIcon: vmIcon))
                    }
            }
            
            GroupBox(String(localized:"Details")) {
                TextField("Title", text: $vmIcon.title)
            }
            
            GroupBox(String(localized: "Share")) {
                VStack {
                    Picker("Please choose one", selection: $imageTypes) {
                        ForEach(ImageType.allCases) { types in
                            Text(types.rawValue.capitalized).tag(types)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            if addMode {
                HStack {
                    Spacer()
                    Button {
                        modelContext.insert(vmIcon)
                        coordinator.toRoot()
                    } label: {
                        Label("Add Icon", systemImage: "plus.rectangle")
                    }
                    Spacer()
                }
            } else {
                
                HStack {
                    Spacer()
                    if imageTypes == .jpeg {
                        let uiImagu = helperImage.shareViewAsImage(iconModel: vmIcon)
                        let img = Image(uiImage: uiImagu ?? UIImage(systemName: "photo")!)
                        ShareLink(item: img, preview: SharePreview(String(localized: "Enjoy!"), image: Image(systemName: "photo"))) {
                            Label("\(imageTypes.rawValue.uppercased())", systemImage: "square.and.arrow.up")
                        }
                    } else {
                        let uiImagu =  helperImage.sharePng(iconModel: vmIcon, type: imageTypes)
                        ShareLink(item: uiImagu, preview: SharePreview(String(localized: "Enjoy!"), image: Image(systemName: "photo"))) {
                            Label("\(imageTypes.rawValue.uppercased())", systemImage: "square.and.arrow.up")
                        }
                    }
                    Spacer()
                }
                
            }
            
        }
        .navigationTitle(addMode ? "Add Icon" : "Edit Icon")
        .alert(messageAlert ,isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                coordinator.toRoot()
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                if addMode {
                    Button {
                        modelContext.insert(vmIcon)
                        messageAlert = "Icono agregado"
                        showAlert = true
                    } label: {
                        Text("Add Icon")
                    }
                } else {
                    Button {
                        do {
                            try modelContext.save()
                            messageAlert = "Model updated"
                            showAlert = true
                        } catch {
                            messageAlert = "Error updating model"
                            showAlert = true
                        }
                        
                    } label: {
                        Text("Save Icon")
                    }
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
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
        coordinator.build(page: .AddIcon(vmIcon: vmIcon, addMode: true))
            .navigationDestination(for: AppPage.self) { page in
                coordinator.build(page: page)
            }
    }
    .environment(\.coordinator, coordinator)
}


