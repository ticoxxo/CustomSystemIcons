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
                IconChildView(icono: icono, bWidth: bWidth, bHeight: bWidth, editable: editable)
            }
                
        }
        .background(
            //Color(hex: vmIcon.background)
            vmIcon.backgroundColor
        )
        //.clipShape(vmIcon.styleShape)
        .clipShape(.circle)
        //.overlay(vmIcon.styleShape.stroke(vmIcon.borderColor, lineWidth: vmIcon.borderWidth * 0.5)) // TODO: Upgrade algorithm for the border width relative to frame size
        .overlay(Circle().stroke(vmIcon.borderColor, lineWidth: vmIcon.borderWidth * 0.5)) 
        .frame(width: bWidth, height: bHeight)
        .padding()
    }
}

#Preview {
    //@Previewable @State var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @Previewable @State var vmIcon = IconModel()
    IconView(vmIcon: vmIcon, bWidth: 100, bHeight: 100, editable: false)
}
