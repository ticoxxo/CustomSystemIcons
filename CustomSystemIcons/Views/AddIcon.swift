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
    // @State private var renderedImage = Image(systemName: "photo")
    
    var body: some View {
        /*
        VStack() {
            GroupBox("Details ") {
                TextField("Task title", text: $vmIcon.title)
                TextField("Description", text: $vmIcon.tareaName)
            }
            
            GroupBox("Choose an Icon") {
                IconView(vmIcon: vmIcon, bWidth: 100, bHeight: 100)
                    .onTapGesture {
                        coordinator.push(page: .EditIcon(vmIcon: vmIcon))
                    }
            }
            
            GroupBox("Date settings") {
                DatePicker("Start date",
                           selection: $vmIcon.startDate,
                           in: vmIcon.startDate...,
                           displayedComponents: [.date])
                DatePicker("Start date",
                           selection: $vmIcon.expireDate,
                           in: vmIcon.expireDate...,
                           displayedComponents: [.date])
               // .frame(width: .infinity, height: 50)
            }
            
            
            Button {
                modelContext.insert(vmIcon)
                coordinator.toRoot()
            } label: {
                Text("Agregar model")
            }
                
        }
        .padding()
         */
        Form {
            GroupBox("Choose an Icon") {
                IconView(vmIcon: vmIcon, bWidth: 100, bHeight: 100, editable: false)
                    .onTapGesture {
                        coordinator.push(page: .EditIcon(vmIcon: vmIcon))
                    }
            }
            
            GroupBox("Details ") {
                TextField("Title", text: $vmIcon.title)
            }
            
            GroupBox("Share ") {
                VStack {
                    Picker("Please choose a color", selection: $imageTypes) {
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
                        ShareLink(item: img, preview: SharePreview("Instafilter image", image: Image(systemName: "photo"))) {
                            Label("Share \(imageTypes.rawValue.uppercased())", systemImage: "airplane")
                        }
                    } else {
                        let uiImagu =  helperImage.sharePng(iconModel: vmIcon, type: imageTypes)
                        ShareLink(item: uiImagu, preview: SharePreview("Instafilter image", image: Image(systemName: "photo"))) {
                            Label("Share \(imageTypes.rawValue.uppercased())", systemImage: "airplane")
                        }
                    }
                    Spacer()
                }
                
            }
            
        }
        .alert("\(helperImage.alertMessage)" ,isPresented: $helperImage.showAlert) {
            /*
            CustomAlertView(message: helperImage.alertMessage, image: helperImage.savedImage, onDismiss: {
                helperImage.showAlert.toggle()
            })
             */
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                if addMode {
                    Button {
                        modelContext.insert(vmIcon)
                        coordinator.toRoot()
                    } label: {
                        Label("Add Icon", systemImage: "plus.rectangle")
                    }
                } else {
                    Button {
                        do {
                            try modelContext.save()
                        } catch {
                            print("Error updating model")
                        }
                        coordinator.toRoot()
                    } label: {
                        Label("Editar Icon", systemImage: "square.and.pencil")
                    }
                }
            }
            
            ToolbarItemGroup(placement: .topBarLeading) {
                Button("Cancel") {
                    coordinator.toRoot()
                }
            }
        }
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


