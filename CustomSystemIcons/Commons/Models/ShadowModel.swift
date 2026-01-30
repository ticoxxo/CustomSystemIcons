//
//  ShadowModel.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 23/04/25.
//

import SwiftUI
import SwiftData


nonisolated struct ShadowModel: Codable {
    var opacity: Double = 0.0
    var radius: CGFloat = 0.0
    var shadowX: CGFloat = 0.0
    var shadowY: CGFloat = 0.0
    var colorComputed: ColorComponents = ColorComponents(color: .gray)
}

extension ShadowModel {
    var shadowColor: Color {
        get { colorComputed.color }
        set { colorComputed.setColor(newValue) }
    }
}
