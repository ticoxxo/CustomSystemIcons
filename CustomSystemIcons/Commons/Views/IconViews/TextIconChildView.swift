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
        if iconModel.textProperties.fontSize > 0 {
            Text(iconModel.textProperties.text)
                .italic(iconModel.textProperties.isItalic)
                .kerning(scaledValue(iconModel.textProperties.letterSpacing))
                .strikethrough(iconModel.textProperties.strikethrough, color: iconModel.textProperties.strikethroughColor.color)
                .underline(iconModel.textProperties.underline, color: iconModel.textProperties.underlineColor.color)
                .font(.system(
                    size: scaledValue(iconModel.textProperties.fontSize),
                    weight: fontWeight(iconModel.textProperties.fontWeight),
                    design: iconModel.textProperties.fontDesign.swiftUIDesign
                ))
                .lineLimit(iconModel.textProperties.lineLimit)
                .lineSpacing(scaledValue(iconModel.textProperties.lineSpacing))
                .fixedSize()
        }
    }
    
    private func scaledValue(_ value: CGFloat) -> CGFloat {
        
        let scaled = value * min(containerSize.width, containerSize.height)
        return max(1, scaled) // Just to avoid swiftui quirks
    }
    
    private func fontWeight(_ weight: FontWeight) -> Font.Weight {
        return weight.rawValue
    }
    
}




#Preview {
    var icon = IconChild(
        name: "Hola, mundo",
        isIcon: false,
        textProperties: TextModel.dataPreviewExample)
    icon.textProperties.fontSize = 0.06
    icon.textProperties.fontWeight = FontWeight.bold
    icon.textProperties.fontDesign = FontDesign.default
    return ZStack {
        Rectangle()
            .background(Color.yellow)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        TextIconChildView(iconModel: icon, containerSize: CGSize(width: 200, height: 200))
            .background(Color.red)
        //Text("Si")
          //  .foregroundStyle(Color.blue)
            
    }
    
    .frame(width: 200, height: 200)
}

#Preview("normal") {
    var icon = IconChild(
        name: "Hola, mundo",
        isIcon: false,
        textProperties: TextModel.dataPreviewExample)
    icon.textProperties.fontSize = 1.0
    icon.textProperties.fontWeight = FontWeight.bold
    return ZStack {
        Rectangle()
            .background(Color.yellow)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        Text("Si")
        .foregroundStyle(Color.blue)
            
    }
    
    .frame(width: 200, height: 200)
}
