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
            
        }
    }
}


#Preview {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @State var vmIcon = IconModel()
    NavigationStack(path: $coordinator.path) {
        coordinator.build(page: .AddIcon(vmIcon: vmIcon))
            .navigationDestination(for: AppPage.self) { page in
                coordinator.build(page: page)
            }
    }
    .environment(\.coordinator, coordinator)
}


