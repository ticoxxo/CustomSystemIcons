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
                .fontWeight(scaledFontWeight(textProps.fontWeight))
                .lineLimit(textProps.lineLimit)
                .lineSpacing(scaledValue(textProps.lineSpacing))
        } else {
            Text(iconModel.name)
        }
    }
    
    private func scaledValue(_ value: CGFloat) -> CGFloat {
        let referenceSize: CGFloat = 100
        let scaleFactor = min(containerSize.width, containerSize.height) / referenceSize
        return value * scaleFactor
    }
    
    private func scaledFontWeight(_ weight: FontWeight) -> Font.Weight {
        // Scale the raw value based on container size
        let scaleFactor = min(containerSize.width, containerSize.height) / 100
        let scaledRawValue = Int(CGFloat(weight.rawValue) * scaleFactor)
        
        // Clamp to valid range (100-900)
        let clampedValue = min(max(scaledRawValue, 100), 900)
        
        // Map to closest Font.Weight
        switch clampedValue {
        case ...150: return .ultraLight
        case 151...250: return .thin
        case 251...350: return .light
        case 351...450: return .regular
        case 451...550: return .medium
        case 551...650: return .semibold
        case 651...750: return .bold
        case 751...850: return .heavy
        default: return .black
        }
    }
}




#Preview {
    let icon = IconChild(
        name: "Hola, mundo",
        isIcon: false,
        textProperties: TextModel.dataPreviewExample)
    
    TextIconChildView(iconModel: icon, containerSize: CGSize(width: 200, height: 200))
        .frame(width: 200, height: 200)
        .background(Color.blue)
}
