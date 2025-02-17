//
//  ColorCodable.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 26/01/25.
//
import SwiftUI

/*
extension Color: Codable {
    enum CodingKeys: CodingKey {
        case red, green, blue, alpha
    }
    
    // Encode Color to a coder
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Convert the Color to UIColor (or NSColor on macOS)
        let uiColor = UIColor(self) // On macOS, use NSColor(self)
        
        // Get the RGBA components from the UIColor
        let components = uiColor.cgColor.components ?? [0, 0, 0, 1] // Default to black with full opacity
        try container.encode(components[0], forKey: .red)
        try container.encode(components[1], forKey: .green)
        try container.encode(components[2], forKey: .blue)
        try container.encode(components[3], forKey: .alpha)
    }
    
    // Decode Color from a decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let red = try container.decode(CGFloat.self, forKey: .red)
        let green = try container.decode(CGFloat.self, forKey: .green)
        let blue = try container.decode(CGFloat.self, forKey: .blue)
        let alpha = try container.decode(CGFloat.self, forKey: .alpha)
        
        self = Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}

extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}
*/
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
