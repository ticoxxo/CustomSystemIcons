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
    var editable: Bool
    var body: some View {
        Image(systemName: icono.name)
            .resizable()
            .scaleEffect(icono.zoom)
            .scaledToFit()
            .foregroundStyle(
                icono.frontColor
            )
            .contentShape(StyleShape.star)
            .clipShape(StyleShape.star)
            .rotationEffect(.degrees(icono.orientation))
            .position(icono.changePosition(width: bWidth, height: bHeight))
            .gesture(
                editable ? DragGesture()
                    .onChanged { value in
                        icono.position = value.location
                        icono.dragging = true
                    }
                    .onEnded {_ in
                        icono.dragging = false
                    }
                : nil
            )
            .simultaneousGesture(
                MagnifyGesture()
                    .onChanged { value in
                        if value.magnification < 0.2 || value.magnification > 1.0 {
                            icono.zoom = value.magnification
                        }
                    }
            )
    }
}

#Preview {
    let icono = IconChild()
    IconChildView(icono: icono, bWidth: 200, bHeight: 200, editable: true)
}
