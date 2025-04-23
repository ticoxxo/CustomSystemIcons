//
//  ShadowModel.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 23/04/25.
//

import SwiftUI
import SwiftData

@Model
final class ShadowModel {
    var opacity: Double
    var radius: CGFloat
    var shadowX: CGFloat
    var shadowY: CGFloat
    var colorComputed: ColorComponents
    
    init(opacity: Double = 0.0,
         radius: CGFloat = 0,
         shadowX: CGFloat = 0.0,
         shadowY: CGFloat = 0.0,
         colorComputed: ColorComponents = ColorComponents(color: .gray)
    ) {
        self.opacity = opacity
        self.radius = radius
        self.shadowX = shadowX
        self.shadowY = shadowY
        self.colorComputed = colorComputed
    }
    
    enum CodingKeys: String, CodingKey {
        case opacity, radius, shadowX, shadowY, colorComputed
    }
}

extension ShadowModel {
    var shadowColor: Color {
        get { colorComputed.color }
        set { colorComputed = ColorComponents(color: newValue) }
    }
}
