//
//  AddIcon.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//

import SwiftUI
import SFSafeSymbols

struct AddIcon: View {
    @Environment(\.coordinator) var coordinator
    @Binding var list: IconsListModel
    @Binding var vmIcon: IconModel
    var body: some View {
        VStack {
            Text("Add Icon view")
            TextField("Task title", text: $vmIcon.title)
            TextField("Description", text: $vmIcon.description)
            IconView(vmIcon: vmIcon)
                .frame(width: 100, height: 100)
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            coordinator.push(page: .GridIconsView(vmIcon: $vmIcon))
                        }
                }
            
            Button {
                list.agregarTarea(vmIcon)
                coordinator.toRoot()
            } label: {
                Text("Agregar model")
            }
                
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @State var list = IconsListModel()
    @Previewable @State var vmIcon = IconModel()
    NavigationStack(path: $coordinator.path) {
        coordinator.build(page: .AddIcon(list: $list, vmIcon: $vmIcon))
            .navigationDestination(for: AppPage.self) { page in
                coordinator.build(page: page)
            }
    }
    .environment(\.coordinator, coordinator)
}
