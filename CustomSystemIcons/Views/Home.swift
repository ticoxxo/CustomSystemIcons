//
//  Home.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//

import SwiftUI
import SwiftData

struct Home: View {
    @Query(sort: \IconModel.tareaName) var listIcons: [IconModel]
    @Environment(\.coordinator) var coordinator
    @Environment(\.modelContext) var modelContext
    var list = IconsListModel()
    
    
    var body: some View {
        VStack {
            List {
                ForEach(listIcons) { item in
                    /*
                     IconRowView(icon: item)
                         .onTapGesture {
                             coordinator.push(page: .AddIcon(vmIcon: item))
                         }
                     */
                    Text("\(item.tareaName)")
                }
                .onDelete(perform: deleteDestinations)
                
            }
            Button {
                if let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
                    print("Database location: \(url.path)")
                }
                @State var icon = IconModel()
                coordinator.push(page: .AddIcon(vmIcon: icon))
            } label: {
                Image(systemName: "plus.app")
                Text("Add Icon")
            }
            Button {
                print(modelContext.sqliteCommand)
            } label: {
                Image(systemName: "plus.app")
                Text("SQL lite")
            }
        }
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for indxex in indexSet {
            let destination = listIcons[indxex]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @State var vmIcon = IconModel()
    NavigationStack(path: $coordinator.path) {
        coordinator.build(page: .Home)
            .navigationDestination(for: AppPage.self) { page in
                coordinator.build(page: page)
            }
    }
    .environment(\.coordinator, coordinator)
}
