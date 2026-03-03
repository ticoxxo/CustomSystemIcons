//
//  ShortcutsProvider.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 02/03/26.
//
import AppIntents

struct ShortcutsProvider: AppShortcutsProvider {
    
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: OpenAppIntent(),
            phrases: [
                "Open \(.applicationName)",
                "Open \(.applicationName) app",
                "Launch \(.applicationName)",
                "Start \(.applicationName)",
                "Run \(.applicationName)",
            ],
            shortTitle: "Open Mochic Craft",
            systemImageName: "square.stack"
        )

        AppShortcut(
            intent: CreateIconIntent(),
            phrases: [
                "Create an icon in \(.applicationName)",
                "Make an icon in \(.applicationName)",
                "Build an icon in \(.applicationName)",
                "Design an icon in \(.applicationName)",
                "Create a custom icon in \(.applicationName)",
            ],
            shortTitle: "Create Icon",
            systemImageName: "paintpalette"
        )
    }
    
}
