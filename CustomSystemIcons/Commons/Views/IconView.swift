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
    var body: some View {
        VStack {
            Image(systemName: vmIcon.iconSF)
                .resizable()
                .scaleEffect(vmIcon.zoom)
                .scaledToFit()
                .foregroundStyle(
                    //vmIcon.buildIt(gradientType: .linear)
                    vmIcon.frontColor
                )
                .rotationEffect(.degrees(vmIcon.orientation))
                .position(vmIcon.changePosition(width: bWidth, height: bHeight))
                .gesture(DragGesture()
                    .onChanged { value in
                    vmIcon.position = value.location
                        vmIcon.dragging = true
                }
                    .onEnded {_ in 
                        vmIcon.dragging = false
                    }
                )
        }
        .background(
            //Color(hex: vmIcon.background)
            vmIcon.backgroundColor
        )
        .clipShape(vmIcon.styleShape)
        .overlay(vmIcon.styleShape.stroke(vmIcon.borderColor, lineWidth: vmIcon.borderWidth * 0.5)) // TODO: Upgrade algorithm for the border width relative to frame size
        .frame(width: bWidth, height: bHeight)
        .padding()
    }
}

#Preview {
    //@Previewable @State var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @Previewable @State var vmIcon = IconModel()
    IconView(vmIcon: vmIcon, bWidth: 100, bHeight: 100)
}
