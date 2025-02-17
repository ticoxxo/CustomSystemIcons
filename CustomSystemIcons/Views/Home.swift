//
//  Home.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//

import SwiftUI
import SwiftData

struct Home: View {
    @Query var listIcons: [IconModel]
    @Environment(\.coordinator) var coordinator
    @Environment(\.modelContext) var modelContext
    var list = IconsListModel()
    
    
    var body: some View {
        VStack {
            List {
                ForEach(listIcons) { item in
                    IconRowView(icon: item)
                        .onTapGesture {
                            coordinator.push(page: .AddIcon(vmIcon: item))
                        }
                }
                .onDelete(perform: deleteDestinations)
                
            }
            Button {
                @State var icon = IconModel()
                coordinator.push(page: .AddIcon(vmIcon: icon))
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

#Preview(traits: .modifier(SampleData())) {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @Query var task: [IconModel]
    NavigationStack(path: $coordinator.path) {
        coordinator.build(page: .Home)
            .navigationDestination(for: AppPage.self) { page in
                coordinator.build(page: page)
            }
    }
    .environment(\.coordinator, coordinator)
}
