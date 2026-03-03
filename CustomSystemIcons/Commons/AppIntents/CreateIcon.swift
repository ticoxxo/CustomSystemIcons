//
//  CreateIcon.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 02/03/26.
//
import AppIntents
import SwiftUI

struct CreateIconIntent: AppIntent {
    static let title: LocalizedStringResource = "Create icon"
    static let description = IntentDescription("Create a quick custom icon")
    
    static let supportedModes: IntentModes = .foreground
    
    @Parameter(title: "Icon description", description: "Provide color, shape and the symbol you want for your icon")
    var description: String
    
    @AppStorage("incomingDescription") var storedDescription = String()
    
    func perform() async throws -> some IntentResult {
        storedDescription = description
        
        return .result()
    }
}


