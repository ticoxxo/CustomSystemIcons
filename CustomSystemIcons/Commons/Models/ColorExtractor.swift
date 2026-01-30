//
//  ColorExtractor.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 27/01/26.
//
import SwiftUI

nonisolated struct ColorExtractor {
    
    func extractColor(_ color: Color) -> Color.Resolved {
       color.resolve(in: EnvironmentValues())
    }
}
