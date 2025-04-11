//
//  EnumColores.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 02/04/25.
//

import SwiftUI

enum MyColor {
    case skyblue
    case lemonYellow
    case steelGray
}

extension MyColor {
    var value: Color {
        get {
            switch self {
            case .skyblue:
                return Color(red: 0.4627, green: 0.8392, blue: 1.0)
            case .lemonYellow:
                return Color(hue: 0.1639, saturation: 1, brightness: 1)
            case .steelGray:
                return Color(white: 0.4745)
            }
        }
    }
}
