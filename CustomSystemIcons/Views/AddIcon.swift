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
    var addMode: Bool
    @State var helperImage: ImageConverter = ImageConverter()
    
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
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Button {
                        helperImage.convertViewAsImage(iconModel: vmIcon)
                    } label: {
                        Label("Download", systemImage: "square.and.arrow.down")
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    let uiImagu =  helperImage.shareViewAsImage(iconModel: vmIcon)
                    let img = Image(uiImage: uiImagu ?? UIImage(systemName: "photo")!)
                    ShareLink(item: img, preview: SharePreview("Instafilter image", image: img)) {
                        Label("Click to share", systemImage: "airplane")
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


