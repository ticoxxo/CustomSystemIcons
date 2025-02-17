//
//  SampleData.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 30/01/25.
//
import SwiftUI
import SwiftData

struct SampleData: PreviewModifier {
    static func makeSharedContext()  throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: IconModel.self, configurations: config)
        let data = IconModel()
        container.mainContext.insert(data)
        container.mainContext.insert(data)
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

struct AddIconSampleData: PreviewModifier {
    static func makeSharedContext()  throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: IconModel.self, configurations: config)
        let data = IconModel()
        container.mainContext.insert(data)
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}
