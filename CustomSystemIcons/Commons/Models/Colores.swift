//
//  Colores.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 25/02/25.
//
import SwiftUI

struct Colores: Codable, Hashable {
    var red: Double
    var blue: Double
    var green: Double
    
    init(red: Double = 0.85,
         blue: Double = 0.85,
         green: Double = 0.85) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}


nonisolated struct ColorComponents: Codable {
    var red: Double = 0
    var green: Double = 0
    var blue: Double = 0
    var alpha: Double = 1
    
    init(red: Double = 0, green: Double = 0, blue: Double = 0, alpha: Double = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    
    init(color: Color) {
        // Use UIColor which is not MainActor-isolated
        let uiColor = UIColor(color)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        self.red = Double(r)
        self.green = Double(g)
        self.blue = Double(b)
        self.alpha = Double(a)
    }
    
    mutating func setColor(_ color: Color?) {
        guard let color = color else {
            return
        }
        
        let resolved = extractColor(color)
        self.red = Double(resolved.red)
        self.green = Double(resolved.green)
        self.blue = Double(resolved.blue)
        self.alpha = Double(resolved.opacity)
    }
    
    func extractColor(_ color: Color) -> Color.Resolved {
       //color.resolve(in: EnvironmentValues())
        let colorExtractor = ColorExtractor()
        return colorExtractor.extractColor(color)
    }
    
    var color: Color {
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}



