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
        VStack() {
            GroupBox("Details ") {
                TextField("Task title", text: $vmIcon.title)
                TextField("Description", text: $vmIcon.tareaName)
            }
            
            GroupBox("Choose an Icon") {
                IconView(vmIcon: vmIcon)
                    .frame(width: 100, height: 100)
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                coordinator.push(page: .GridIconsView(vmIcon: vmIcon))
                            }
                    }
                    .onTapGesture {
                        //coordinator.push(page: .EditIcon(vmIcon: $vmIcon))
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
    }
}


#Preview(traits: .modifier(SampleData())) {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @Query var task: [IconModel]
    @Previewable @State var vmIcon = IconModel()
    NavigationStack(path: $coordinator.path) {
        coordinator.build(page: .AddIcon(vmIcon: vmIcon))
            .navigationDestination(for: AppPage.self) { page in
                coordinator.build(page: page)
            }
    }
    .environment(\.coordinator, coordinator)
}


