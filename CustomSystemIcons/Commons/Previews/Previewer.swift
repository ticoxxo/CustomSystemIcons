//
//  Previewer.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 30/01/25.
//
import SwiftUI
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer

    let list: IconsListModel
    let vmIcon: IconModel
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: IconModel.self, configurations: config)
        
        list = IconsListModel()
        vmIcon = IconModel()
        
        container.mainContext.insert(vmIcon)
    }
}
