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
            
            //Color(hex: vmIcon.background)
            if vmIcon.backgroundImage.backgroundImage != nil {
                
                BackgroundView(background: vmIcon.backgroundImage)
                    
                
            } else {
                vmIcon.backgroundColor
            }
            
        }
        .clipShape(vmIcon.styleShape)
        .overlay(
            vmIcon.styleShape.stroke(vmIcon.borderColor,
                                     lineWidth: bWidth * vmIcon.borderWidth)
        )
        .shadow(
            color: vmIcon.shadows.shadowColor.opacity(vmIcon.shadows.opacity),
            radius: vmIcon.shadows.radius,
            x: vmIcon.shadows.shadowX,
            y: vmIcon.shadows.shadowY
        )
        .frame(width: bWidth, height: bHeight)
        .padding()
    }
}
/*
 if let imageData =  vmIcon.backgroundImage, let uiImage = UIImage(data: imageData) {
 */

#Preview {
    //@Previewable @State var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @Previewable @State var vmIcon = IconModel()
    IconView(vmIcon: vmIcon, bWidth: 200, bHeight: 200, editable: true)
}
