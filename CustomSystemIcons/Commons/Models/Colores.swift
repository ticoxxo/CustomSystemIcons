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

struct ColorComponents: Codable {
var red: Double
    var green: Double
    var blue: Double
    var alpha: Double

    init(color: Color) {
        if let components = color.cgColor?.components {
            self.red = Double(components[0])
            self.green = Double(components[1])
            self.blue = Double(components[2])
            self.alpha = Double(components[3])
        } else {
            self.red = 0
            self.green = 0
            self.blue = 0
            self.alpha = 1
        }
    }

    var color: Color {
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}
