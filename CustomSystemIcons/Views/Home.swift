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
    @Query(filter: #Predicate<IconModel> { $0.isFavorite }, sort: \IconModel.creationDate) var favoriteListIcons: [IconModel]
    @Environment(\.coordinator) var coordinator
    @Environment(\.modelContext) var modelContext
    var list = IconsListModel()
    @State private var searchText = ""
    @State private var messageAlert = ""
    @State private var showAlert = false
    @State private var favoriteFilter = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Spacer()
                    TextField("Label.Search", text: $searchText)
                        .customTextField(label: "Label.Search.Accessibility", hint: "Label.Search.Accessibility.Hint", text: $searchText)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                .padding()

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredIcons) { item in
                            ListRowView(item: item)
                                .onTapGesture {
                                    coordinator.push(page: .AddIcon(vmIcon: item, addMode: false))
                                }
                        }
                    }
                    .padding()
                }
                Spacer()
                Button {
                    @State var icon = IconModel()
                    coordinator.push(page: .AddIcon(vmIcon: icon, addMode: true))
                } label: {
                    Label("Label.AddIcon", systemImage: "plus.app")
                }
                .customAccessibility(label: "Label.AddIcon.Accessibility", hint: "Label.AddIcon.Accessibility.Hint")
                .buttonStyle(CustomButton(color: MyColor.skyblue.value, width: geometry.size.width / 2))
                
            }
        }
        .navigationTitle("Icons")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    favoriteFilter.toggle()
                } label: {
                    Image(systemName: favoriteFilter ? "star.fill" : "star")
                }
                .customAccessibility(label: "Label.AddIcon.Accessibility", hint: "Label.AddIcon.Accessibility")
            }
        }
        .alert(messageAlert, isPresented: $showAlert) {
            Button {
                
            } label: {
                Text("Label.OK")
            }
            .customAccessibility(label: "Label.OK.Accessibility", hint: "Label.OK.Accessibility.Hint")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
