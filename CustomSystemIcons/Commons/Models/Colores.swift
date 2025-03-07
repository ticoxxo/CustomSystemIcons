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
