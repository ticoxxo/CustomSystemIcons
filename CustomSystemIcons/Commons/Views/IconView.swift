//
//  AddColor.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 17/01/25.
//

import SwiftUI
import SFSafeSymbols

struct IconView: View {
    var vmIcon: IconModel
    var bWidth: CGFloat
    var bHeight: CGFloat
    var editable: Bool
    var body: some View {
        ZStack {
            ForEach(vmIcon.icons) { icono in
                IconChildView(icono: icono, editable: editable)
            }
        }
        .background {
            if vmIcon.backgroundImage.backgroundImage != nil {
                BackgroundView(background: vmIcon.backgroundImage)
            } else {
                vmIcon.backgroundColor
            }
        }
        .clipShape(vmIcon.styleShape)
        .overlay(
            vmIcon.styleShape
                .strokeBorder(vmIcon.borderColor, lineWidth: bWidth * vmIcon.borderWidth)
        )
        .shadow(
            color: vmIcon.shadows.shadowColor.opacity(vmIcon.shadows.opacity),
            radius: vmIcon.shadows.radius,
            x: vmIcon.shadows.shadowX,
            y: vmIcon.shadows.shadowY
        )
        .frame(width: bWidth , height: bHeight)
    }
}

#Preview {
    //@Previewable @State var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    //@Previewable @State var vmIcon = IconModel(styleShape: .square(radio: 5), borderWidth: 0.05)
    //@Previewable @State var vmIcon = IconModel(styleShape: .circle, borderWidth: 0.01)
    //@Previewable @State var vmIcon = IconModel(styleShape: .star(radio: 5), borderWidth: 0.05)
    //@Previewable @State var vmIcon = IconModel(styleShape: .triangle(radio: 30), borderWidth: 0.05)
    //@Previewable @State var vmIcon = IconModel(styleShape: .square(radio: 30), borderWidth: 0.05)
    @Previewable @State var vmIcon = IconModel( )
    vmIcon.backgroundColor = Color.blue
    vmIcon.borderWidth = 0.09
    vmIcon.styleShape = .hexagon(radio: 0.0)
    return ZStack {
        
        Rectangle()
            .fill(.red)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        IconView(vmIcon: vmIcon, bWidth: 200, bHeight: 200, editable: true)
    }
    .foregroundColor(Color.black)
    .background(Color.primary
                            .colorInvert()
                            .opacity(0.75))
    .frame(width: 200, height: 200)
        
}
