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
                
                
                
        }
        .background(
            //Color(hex: vmIcon.background)
            vmIcon.backgroundColor
        )
        .clipShape(vmIcon.styleShape)
        .overlay(vmIcon.styleShape.stroke(vmIcon.borderColor, lineWidth: vmIcon.borderWidth))
        .padding()
    }
}

#Preview {
    //@Previewable @State var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @Previewable @State var vmIcon = IconModel()
    IconView(vmIcon: vmIcon)
}
