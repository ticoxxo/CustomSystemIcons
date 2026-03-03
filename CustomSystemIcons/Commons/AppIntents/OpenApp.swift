//
//  OpenApp.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 02/03/26.
//
import AppIntents

struct OpenAppIntent: AppIntent {
        static let title = LocalizedStringResource(stringLiteral: "Open mochic")
        static let description = IntentDescription(stringLiteral: "This intent opens the app Mochic Craft")
        
        static let openAppWhenRun: Bool = true

        func perform() async throws -> some IntentResult {
            return .result()
        }
}
