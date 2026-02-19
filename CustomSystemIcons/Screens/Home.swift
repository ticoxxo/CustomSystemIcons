//
//  Home.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//

import SwiftUI
import SwiftData

struct Home: View {
    @Environment(\.coordinator) var coordinator
    @Environment(\.modelContext) var modelContext
    var list = IconsListModel()
    @State private var searchText = String()
    @State private var messageAlert = ""
    @State private var showAlert = false
    @State private var favoriteFilter = false
    
    // Use computed predicate for dynamic filtering
    private var iconPredicate: Predicate<IconModel> {
        let trimmedSearch = searchText.trimmingCharacters(in: .whitespaces).lowercased()
        
        if favoriteFilter && !trimmedSearch.isEmpty {
            return #Predicate<IconModel> { icon in
                icon.isFavorite && icon.title.localizedStandardContains(trimmedSearch)
            }
        } else if favoriteFilter {
            return #Predicate<IconModel> { icon in
                icon.isFavorite
            }
        } else if !trimmedSearch.isEmpty {
            return #Predicate<IconModel> { icon in
                icon.title.localizedStandardContains(trimmedSearch)
            }
        } else {
            return #Predicate<IconModel> { _ in true }
        }
    }
    
    // Single query with dynamic predicate
    @Query(sort: \IconModel.creationDate) private var allIcons: [IconModel]
    
    private var filteredIcons: [IconModel] {
        do {
            let descriptor = FetchDescriptor<IconModel>(
                predicate: iconPredicate,
                sortBy: [SortDescriptor(\IconModel.creationDate)]
            )
            return try modelContext.fetch(descriptor)
        } catch {
            return []
        }
    }

    var body: some View {
        VStack {
            TextField("Label.Search", text: $searchText)
                .customTextField(label: "Label.Search.Accessibility", hint: "Label.Search.Accessibility.Hint", text: $searchText)
                .frame(maxWidth: .infinity)
                .padding()
            
            CustomAdaptiveGrid(columns: 2) {
                ForEach(filteredIcons) { item in
                    ListRowView(item: item)
                        .containerRelativeFrame(.vertical) { length, axis in
                            0.45 * length
                        }
                        .containerRelativeFrame(.horizontal) { length, axis in
                            0.40 * length
                        }
                        .onTapGesture {
                            coordinator.push(page: .AddIcon(vmIcon: item, addMode: false))
                        }
                }
            }
            .padding()
            
            Button {
                @State var icon = IconModel()
                coordinator.push(page: .AddIcon(vmIcon: icon, addMode: true))
            } label: {
                Label("Label.AddIcon", systemImage: "plus.app")
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
    }
}

extension Home {
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = allIcons[index]
            modelContext.delete(destination)
        }
    }
}

struct CustomAdaptiveGrid<Content: View>: View {
    let columns: Int?
    @ViewBuilder var content: () -> Content
    
    
    var numberOfColumns: [GridItem] {
        guard let col = columns else {
            return [GridItem(.adaptive(minimum: 60, maximum: 80))]
        }
        
        return Array(repeating: GridItem(.flexible()), count: col)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: numberOfColumns, spacing: 16) {
                content()
            }
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
