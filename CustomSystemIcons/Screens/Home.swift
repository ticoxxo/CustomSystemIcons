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
    @State private var searchText = String()
    @State private var debouncedSearchText = String()
    @State private var favoriteFilter = false
    
    @Query(sort: \IconModel.creationDate) private var allIcons: [IconModel]
    
    private var filteredIcons: [IconModel] {
        let trimmedSearch = debouncedSearchText.trimmingCharacters(in: .whitespaces)
        return allIcons.filter { icon in
            let matchesSearch = trimmedSearch.isEmpty || icon.title.localizedStandardContains(trimmedSearch)
            let matchesFavorite = !favoriteFilter || icon.isFavorite
            return matchesSearch && matchesFavorite
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
                    Button(action: { selectIcon(item) }) {
                        ListRowView(item: item)
                            .containerRelativeFrame(.vertical) { length, axis in
                                0.45 * length
                            }
                            .containerRelativeFrame(.horizontal) { length, axis in
                                0.40 * length
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
            .overlay {
                if filteredIcons.isEmpty {
                    if !debouncedSearchText.isEmpty {
                        ContentUnavailableView.search(text: debouncedSearchText)
                    } else if favoriteFilter {
                        ContentUnavailableView(
                            "No Favorites",
                            systemImage: "star",
                            description: Text("Try removing the filter or add favorites.")
                        )
                    } else {
                        ContentUnavailableView(
                            "No Icons",
                            systemImage: "square.grid.2x2",
                            description: Text("Create your first icon to get started.")
                        )
                    }
                }
            }
            
            Button(action: addNewIcon) {
                Label("Label.AddIcon", systemImage: "plus.app")
            }
        }
        .navigationTitle("Icons")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: toggleFavoriteFilter) {
                    Image(systemName: favoriteFilter ? "star.fill" : "star")
                }
                .customAccessibility(label: "Label.AddIcon.Accessibility", hint: "Label.AddIcon.Accessibility")
            }
        }
        .task(id: searchText) {
            let currentValue = searchText
            try? await Task.sleep(nanoseconds: 250_000_000)
            if !Task.isCancelled {
                debouncedSearchText = currentValue
            }
        }
    }

    private func selectIcon(_ item: IconModel) {
        coordinator.push(page: .AddIcon(vmIcon: item, addMode: false))
    }

    private func addNewIcon() {
        let icon = IconModel()
        coordinator.push(page: .AddIcon(vmIcon: icon, addMode: true))
    }

    private func toggleFavoriteFilter() {
        favoriteFilter.toggle()
    }
}

struct CustomAdaptiveGrid<Content: View>: View {
    let columns: Int?
    @ViewBuilder let content: Content

    init(columns: Int? = nil, @ViewBuilder content: () -> Content) {
        self.columns = columns
        self.content = content()
    }

    var numberOfColumns: [GridItem] {
        guard let col = columns else {
            return [GridItem(.adaptive(minimum: 60, maximum: 80))]
        }

        return Array(repeating: GridItem(.flexible()), count: col)
    }

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: numberOfColumns, spacing: 16) {
                content
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
