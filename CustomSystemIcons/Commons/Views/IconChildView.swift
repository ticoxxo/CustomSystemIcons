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
                .position(x: icono.positionX == 0 ? geometry.size.width / 2 : icono.positionX ,
                          y: icono.positionY == 0 ? geometry.size.height / 2 : icono.positionY)
                .gesture(
                    editable ? DragGesture()
                        .onChanged { value in
                            icono.positionX = value.location.x
                            icono.positionY = value.location.y
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
    IconChildView(icono: icono, bWidth: 200, bHeight: 200, editable: true)
}
