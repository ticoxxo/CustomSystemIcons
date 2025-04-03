//
//  Home.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//

import SwiftUI
import SwiftData

struct Home: View {
    @Query(sort: \IconModel.creationDate) var listIcons: [IconModel]
    @Query(filter: #Predicate<IconModel> { $0.isFavorite } ,sort: \IconModel.creationDate) var favoriteListIcons: [IconModel]
    @Environment(\.coordinator) var coordinator
    @Environment(\.modelContext) var modelContext
    var list = IconsListModel()
    @State private var searchText = ""
    @State private var messageAlert = ""
    @State private var showAlert = false
    @State private var favoriteFilter = false
    
    var body: some View {
        VStack {
            List(filteredIcons) { item in
                ListRowView(item: item)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        coordinator.push(page: .AddIcon(vmIcon: item, addMode: false))
                    }
                    .overlay( alignment: .topTrailing) {
                        StarView(item: item)
                            .onTapGesture {
                                item.isFavorite.toggle()
                                do {
                                    try modelContext.save()
                                } catch {
                                    messageAlert = "Error updating favorite"
                                    showAlert = true
                                }
                            }
                    }
            }
            .listStyle(.plain)
            .searchable(text: $searchText, prompt: "Search Icon")
            
            Button {
                @State var icon = IconModel()
                coordinator.push(page: .AddIcon(vmIcon: icon, addMode: true))
            } label: {
                Label("Add Icon", systemImage: "plus.app")
            }
            .buttonStyle(CustomButton(color: MyColor.skyblue.value, width: horizontalPadding / 2))
            
        }
        .navigationTitle("Icons")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    favoriteFilter.toggle()
                } label : {
                    Image(systemName: favoriteFilter ? "star.fill" : "star")
                }
                
            }
        }
        .alert(messageAlert ,isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
        
    }
}

extension Home {
    var filteredIcons: [IconModel] {
            if searchText.isEmpty {
                let list = favoriteFilter ? favoriteListIcons : listIcons
                return list
            } else {
                let list = favoriteFilter ?
                           favoriteListIcons.filter { $0.title.lowercased().contains(searchText.lowercased()) } :
                           listIcons.filter { $0.title.lowercased().contains(searchText.lowercased()) }
                return list
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
