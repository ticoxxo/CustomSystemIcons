//
//  TextIconChildView.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 30/01/26.
//

import SwiftUI


//MARK: Add custom fonts
struct TextIconChildView: View {
    let iconModel: IconChild
    let containerSize: CGSize
    
    var body: some View {
        if let textProps = iconModel.textProperties {
            Text(iconModel.name)
                .italic(textProps.isItalic)
                .kerning(scaledValue(textProps.letterSpacing))
                .strikethrough(textProps.strikethrough, color: textProps.strikethroughColor.color)
                .underline(textProps.underline, color: textProps.underlineColor.color)
                .font(.system(size: scaledValue(textProps.fontSize)))
                .fontWeight(fontWeight(textProps.fontWeight))
                .lineLimit(textProps.lineLimit)
                .lineSpacing(scaledValue(textProps.lineSpacing))
                .fixedSize()
        } else {
            Text(iconModel.name)
                .fixedSize()
        }
    }
    
    private func scaledValue(_ value: CGFloat) -> CGFloat {
        let referenceSize: CGFloat = 100
        let scaleFactor = min(containerSize.width, containerSize.height) / referenceSize
        return value * scaleFactor
    }
    
    private func fontWeight(_ weight: FontWeight) -> Font.Weight {
        // Return the Font.Weight directly from FontWeight
        return weight.rawValue
    }
}




#Preview {
    let icon = IconChild(
        name: "Hola, mundo",
        isIcon: false,
        textProperties: TextModel.dataPreviewExample)
    
    TextIconChildView(iconModel: icon, containerSize: CGSize(width: 200, height: 200))
        .background(Color.blue)
}
