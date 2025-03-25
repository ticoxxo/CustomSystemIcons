//
//  SampleData.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 30/01/25.
//
import SwiftUI
import SwiftData

let sampleTask = [
    IconModel(title: "Numero 1"),
    IconModel(title: "Sample Task 2"),
    IconModel(title: "Task 3")
]

struct SampleData: PreviewModifier {
    static func makeSharedContext()  throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: IconModel.self, configurations: config)
        for task in sampleTask {
            container.mainContext.insert(task)
        }
        
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var sampleData: Self = .modifier(SampleData())
        
}
