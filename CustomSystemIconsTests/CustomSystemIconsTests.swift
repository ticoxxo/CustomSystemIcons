//
//  CustomSystemIconsTests.swift
//  CustomSystemIconsTests
//
//  Created by Alberto Almeida on 21/04/25.
//

import Testing
@testable import CustomSystemIcons
import SwiftData
import SwiftUI


struct CustomSystemIconsTests {
    var container: ModelContainer!
    var context: ModelContext!
    
    @MainActor
    mutating func setUp() throws {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            container = try ModelContainer(for: IconModel.self, configurations: config)
            context = container.mainContext
        }

        mutating func tearDown() {
            container = nil
            context = nil
        }

    @Test("Check if title it's set") func setTitle() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let vmIcon = IconModel()
        vmIcon.title = "Test"
        
        #expect(vmIcon.title == "Test")
    }
    
    @Test("Adding a new icon") func addIcon() async throws {
        let vmIcon = IconModel()
        vmIcon.addIcon()
        
        #expect(vmIcon.icons.count > 1)
    }
    
    @MainActor
    @Test("Saving an icon in context")
    mutating func savingIconInContext() async throws {
        try setUp()
        defer { tearDown() }
        // Create and configure the icon model
        let icon = IconModel()
        icon.title = "Test Icon"

        // Insert the icon into the context
        context.insert(icon)
        try context.save()
        
        // Fetch the icon to verify it exists in the context
        //let fetchRequest = FetchRequest<IconModel>(predicate: #Predicate { $0.title == "Test Icon" })
        //let fetchedIcons = try context.fetch(fetchRequest)
        let fetchDescriptor = FetchDescriptor<IconModel>(predicate: #Predicate { $0.title == "Test Icon" })
        let fetchedIcons = try context.fetch(fetchDescriptor)
        

        // Assert that the icon exists in the context
        assert(!fetchedIcons.isEmpty, "The context should contain the saved icon.")
    }
    
    @MainActor
    @Test("Deleting an icon in context")
    mutating func deleteIconInContext() async throws {
        try setUp()
        defer { tearDown() }
        // Create and configure the icon model
        let icon = IconModel()
        icon.title = "Test Icon"

        // Insert the icon into the context
        context.insert(icon)
        try context.save()
        
        // Delete the icon
        context.delete(icon)
        
        // Fetch the icon to verify it exists in the context
        //let fetchRequest = FetchRequest<IconModel>(predicate: #Predicate { $0.title == "Test Icon" })
        //let fetchedIcons = try context.fetch(fetchRequest)
        let fetchDescriptor = FetchDescriptor<IconModel>(predicate: #Predicate { $0.title == "Test Icon" })
        let fetchedIcons = try context.fetch(fetchDescriptor)
        

        // Assert that the icon exists in the context
        assert(fetchedIcons.isEmpty, "The context should be empty.")
    }

}
