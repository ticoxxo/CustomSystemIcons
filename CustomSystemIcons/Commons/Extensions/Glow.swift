//
//  Glow.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 02/04/25.
//

import SwiftUI

extension View {
    func glow(color: Color = .red, radius: CGFloat = 20) -> some View {
            self
                .shadow(color: color, radius: radius / 2 )
        }
}
