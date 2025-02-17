//
//  GradientType.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 18/01/25.
//
import SwiftUI

enum GradientDirection {
    case top
    case bottom
    case left
    case right
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case center

    // Computed property to return the corresponding UnitPoint for each case
    var unitPoint: UnitPoint {
        switch self {
        case .top:
            return UnitPoint(x: 0.5, y: 0)  // Top center
        case .bottom:
            return UnitPoint(x: 0.5, y: 1)  // Bottom center
        case .left:
            return UnitPoint(x: 0, y: 0.5)  // Left center
        case .right:
            return UnitPoint(x: 1, y: 0.5)  // Right center
        case .topLeft:
            return UnitPoint(x: 0, y: 0)    // Top-left corner
        case .topRight:
            return UnitPoint(x: 1, y: 0)    // Top-right corner
        case .bottomLeft:
            return UnitPoint(x: 0, y: 1)    // Bottom-left corner
        case .bottomRight:
            return UnitPoint(x: 1, y: 1)    // Bottom-right corner
        case .center:
            return UnitPoint(x: 0.5, y: 0.5) // Center
        }
    }
}

enum GradientType:CaseIterable, Codable{
    case linear
    case radial
    case angular
    case elliptical
}

extension GradientType {
    init() {
        self = .linear
    }
}
