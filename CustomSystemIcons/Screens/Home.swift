//
//  Home.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//

import SwiftUI
import SwiftData
import SFSafeSymbols

struct Home: View {
    @Environment(\.coordinator) var coordinator
    @State private var searchText = String()
    @State private var debouncedSearchText = String()
    @State private var favoriteFilter = false
    @Environment(\.modelContext) var modelContext
    
    @AppStorage("incomingDescription") private var incomingDescription = String()
    
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
                        ListRowView(item: item, modelContext: modelContext)
                            .containerRelativeFrame(.vertical) { length, axis in
                                0.40 * length
                            }
                            .containerRelativeFrame(.horizontal) { length, axis in
                                0.30 * length
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
            .buttonStyle(.glass)
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
        .onChange(of: incomingDescription) { _, newQuestion in
            // We reset path
            if coordinator.path.count > 0 {
                coordinator.toRoot()
            }
            let tuple = unravelColorIntent(incomingDescription)
            let shape = unravelShapeIntent(tuple.1)
            let icono = unravelIconIntent(shape.1)
            let icon = IconModel()
            icon.borderWidth = 0.05
            icon.borderColorComputed = ColorComponents(color: tuple.0)
            icon.shape = shape.0
            icon.shape.innerRadiusRatio = 0.5
            icon.icons[0].name = icono
            icon.icons[0].frontColorComputed = ColorComponents(color: tuple.0)
            coordinator.push(page: .AddIcon(vmIcon: icon, addMode: true))
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
    
    private func unravelIconIntent (_ description: String?) -> String {
        guard let text = description else {
            return "star.fill"
        }
        
        let symbolsStrings = SFSymbol.allSymbols.map { $0.rawValue.lowercased() }
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        let filtro = query.components(separatedBy: .whitespaces)
            .map { $0.trimmingCharacters(in: .punctuationCharacters) }
            .filter { $0.count >= 4 }

        for token in filtro {
            if let match = symbolsStrings.first(where: { $0.contains(token) }) {
                return match
            }
        }

        return "star.fill"
    }
    
    private func unravelShapeIntent(_ description: String?) -> (Figura, String?) {
        guard let description else {
            return (Figura(), nil)
        }

        let trimmedDescription = description.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedDescription.isEmpty else {
            return (Figura(), "")
        }

        var newString = trimmedDescription

        if let match = ShapedName.firstMatch(in: newString) {
            var removalRange = match.range
            let punctuation = CharacterSet.punctuationCharacters.union(.whitespacesAndNewlines)

            while removalRange.lowerBound > newString.startIndex {
                let beforeIndex = newString.index(before: removalRange.lowerBound)
                let scalar = newString[beforeIndex].unicodeScalars
                if scalar.allSatisfy({ punctuation.contains($0) }) {
                    removalRange = beforeIndex..<removalRange.upperBound
                } else {
                    break
                }
            }

            while removalRange.upperBound < newString.endIndex {
                let afterIndex = removalRange.upperBound
                let scalar = newString[afterIndex].unicodeScalars
                if scalar.allSatisfy({ punctuation.contains($0) }) {
                    removalRange = removalRange.lowerBound..<newString.index(after: afterIndex)
                } else {
                    break
                }
            }

            newString.removeSubrange(removalRange)
            while newString.contains("  ") {
                newString = newString.replacingOccurrences(of: "  ", with: " ")
            }
            newString = newString.trimmingCharacters(in: .whitespacesAndNewlines)
            return (match.shape.figura, newString)
        }

        return (Figura(), newString)
    }
    
    private func unravelColorIntent(_ description: String) -> (Color, String?) {
        let trimmedDescription = description.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedDescription.isEmpty else {
            return (.black, nil)
        }

        var newString = trimmedDescription // "I want an icon shaped like a red star that looks blue"

        if let match = ColorName.firstMatch(in: newString) {
            var removalRange = match.range
            let punctuation = CharacterSet.punctuationCharacters.union(.whitespacesAndNewlines)

            while removalRange.lowerBound > newString.startIndex {
                let beforeIndex = newString.index(before: removalRange.lowerBound)
                let scalar = newString[beforeIndex].unicodeScalars
                if scalar.allSatisfy({ punctuation.contains($0) }) {
                    removalRange = beforeIndex..<removalRange.upperBound
                } else {
                    break
                }
            }

            while removalRange.upperBound < newString.endIndex {
                let afterIndex = removalRange.upperBound
                let scalar = newString[afterIndex].unicodeScalars
                if scalar.allSatisfy({ punctuation.contains($0) }) {
                    removalRange = removalRange.lowerBound..<newString.index(after: afterIndex)
                } else {
                    break
                }
            }

            newString.removeSubrange(removalRange)
            while newString.contains("  ") {
                newString = newString.replacingOccurrences(of: "  ", with: " ")
            }
            newString = newString.trimmingCharacters(in: .whitespacesAndNewlines)
            return (match.color.value, newString)
        }

        return (.black, newString)
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
