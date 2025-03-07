//
//  IconChildView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 25/02/25.
//

import SwiftUI

struct IconChildView: View {
    var icono: IconChild
    var bWidth: CGFloat
    var bHeight: CGFloat
    var body: some View {
        Image(systemName: icono.name)
            .resizable()
            .scaleEffect(icono.zoom)
            .scaledToFit()
            .foregroundStyle(
                //vmIcon.buildIt(gradientType: .linear)
                icono.frontColor
            )
            .contentShape(StyleShape.star)
            .clipShape(StyleShape.star)
            .rotationEffect(.degrees(icono.orientation))
            .position(icono.changePosition(width: bWidth, height: bHeight))
            .gesture(DragGesture()
                .onChanged { value in
                    icono.position = value.location
                    icono.dragging = true
            }
                .onEnded {_ in
                    icono.dragging = false
                }
            )
            
    }
}

#Preview {
    let icono = IconChild()
    IconChildView(icono: icono, bWidth: 200, bHeight: 200)
}
