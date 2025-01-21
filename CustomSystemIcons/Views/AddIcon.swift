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
    @State var tarea  = IconModel(frontColor: [.red, .blue])
    var body: some View {
        VStack {
            Text("Add Icon view")
            TextField("Task title", text: $tarea.title)
            TextField("Description", text: $tarea.description)
            Image(systemSymbol: tarea.icon)
                .font(.system(size: 50))
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            coordinator.push(page: .GridIconsView(vmIcon: $tarea))
                        }
                }
                
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var coordinator = Coordinator()
    NavigationStack(path: $coordinator.path) {
        coordinator.build(page: .AddIcon)
            .navigationDestination(for: AppPage.self) { page in
                coordinator.build(page: page)
            }
    }
    .environment(\.coordinator, coordinator)
}
