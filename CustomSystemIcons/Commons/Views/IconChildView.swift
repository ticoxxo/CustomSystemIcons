//
//  IconChildView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 25/02/25.
//

import SwiftUI

struct IconChildView: View {
    var icono: IconChild
    var editable: Bool
   
    var body: some View {
        GeometryReader { geometry in
            Image(systemName: icono.name)
                .resizable()
                .scaleEffect(CGFloat(icono.zoom))
                .scaledToFit()
                .foregroundStyle(
                    icono.frontColor
                )
                .contentShape(StyleShape.star)
                .clipShape(StyleShape.square)
                .rotationEffect(.degrees(icono.orientation))
                .frame(width: geometry.size.width, height: geometry.size.height)
                .position(
                                    x: max(0, min(geometry.size.width, icono.positionX == 0 ? geometry.size.width / 2 : geometry.size.width * icono.positionX)),
                                    y: max(0, min(geometry.size.height, icono.positionY == 0 ? geometry.size.height / 2 : geometry.size.height * icono.positionY))
                                )
                .gesture(
                    editable ? DragGesture()
                        .onChanged { value in
                            icono.positionX = value.location.x / geometry.size.width
                                                        icono.positionY = value.location.y / geometry.size.height
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
                                icono.zoom = Float(value.magnification)
                            }
                        }
                )
        }
    }
}

#Preview {
    let icono = IconChild()
    IconChildView(icono: icono, editable: true)
}
