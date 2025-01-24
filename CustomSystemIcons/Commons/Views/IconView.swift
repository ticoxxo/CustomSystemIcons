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
        
            Image(systemSymbol: vmIcon.icon)
                .resizable()
                .scaleEffect(vmIcon.zoom)
                .scaledToFit()
                .background(
                    vmIcon.background
                )
                .foregroundStyle(
                    vmIcon.buildIt(gradientType: vmIcon.gradientType)
                )
                .rotationEffect(.degrees(vmIcon.orientation))
                .clipShape(Circle())
                .overlay(Circle().stroke(vmIcon.boderColor, lineWidth: vmIcon.borderWidth))
    }
}

#Preview {
    //@Previewable @State var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @Previewable @State var vmIcon = IconModel()
    IconView(vmIcon: vmIcon)
}
