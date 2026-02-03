//
//  IconChildView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 25/02/25.
//

import SwiftUI


//MARK: Add clip shape to this views
struct IconChildView: View {
    var icono: IconChild
    var editable: Bool
   
    var body: some View {
        GeometryReader { geometry in
        
            TextOrImage(geometry: geometry)
                .scaleEffect(CGFloat(icono.zoom))
                .scaledToFit()
                .foregroundStyle(
                    icono.frontColor
                )
                //.contentShape(StyleShape.star)
                //.clipShape(StyleShape.square)
                .modifier(
                    DistortionEffect(xDistortion: icono.xDistortion, yDistortion: icono.yDistortion)
                )
                .rotationEffect(.degrees(icono.orientation))
                
                .frame(width: geometry.size.width, height: geometry.size.height)
                .position(
                                    x: max(0, min(geometry.size.width, icono.positionX == 0 ? geometry.size.width / 2 : geometry.size.width * icono.positionX)),
                                    y: max(0, min(geometry.size.height, icono.positionY == 0 ? geometry.size.height / 2 : geometry.size.height * icono.positionY))
                                )
                .shadow(
                    color: icono.shadows.shadowColor.opacity(icono.shadows.opacity),
                    radius: icono.shadows.radius,
                    x: icono.shadows.shadowX,
                    y: icono.shadows.shadowY
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
                .accessibilityZoomAction { action in
                    switch action.direction {
                    case .zoomIn:
                        icono.zoom = Float(icono.zoom + 0.1)
                    case .zoomOut:
                        icono.zoom = Float(icono.zoom - 0.1)
                    }
                }
                .accessibilityAction(named: Text("Drag.Right")) {
                    icono.positionX = icono.positionX + 0.1
                }
                .accessibilityAction(named: Text("Drag.Left")) {
                    icono.positionX = icono.positionX - 0.1
                }
                .accessibilityAction(named: Text("Drag.Top")) {
                    icono.positionX = icono.positionY + 0.1
                }
                .accessibilityAction(named: Text("Drag.Bottom")) {
                    icono.positionX = icono.positionY - 0.1
                }
        }
    }
    
    @ViewBuilder
    func TextOrImage(geometry: GeometryProxy) -> some View {
        
        if icono.isIcon {
            Image(systemName: icono.name)
                .resizable()
                .customAccessibility(label: "Icon.Child", hint: "Drag to change of place", isButton: true)
        } else {
            TextIconChildView(iconModel: icono, containerSize: geometry.size)
        }
    }
}



#Preview {
    let icono = IconChild(isIcon: true)
    
    IconChildView(icono: icono, editable: true)
}

#Preview("Child view text") {
    let icon = IconChild(
        name: "Hola, mundo",
        isIcon: false,
        textProperties: TextModel.dataPreviewExample)
    
    IconChildView(icono: icon, editable: true)
}
