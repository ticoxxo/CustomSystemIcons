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
                    VStack {
                        IconView(vmIcon: item, bWidth: 50, bHeight: 50, editable: false)
                            .onTapGesture {
                                coordinator.push(page: .AddIcon(vmIcon: item, addMode: false))
                            }
                        Text("\(item.title)")
                            .font(.footnote)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .onDelete(perform: deleteDestinations)
                
            }
            Button {
                @State var icon = IconModel()
                coordinator.push(page: .AddIcon(vmIcon: icon, addMode: true))
            } label: {
                Image(systemName: "plus.app")
                Text("Add Icon")
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

#Preview(traits: .sampleData) {
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
