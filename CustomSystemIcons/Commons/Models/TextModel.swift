//
//  TextModel.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 30/01/26.
//
import SwiftUI
import SwiftData

nonisolated struct TextModel: Codable, Hashable, Equatable {
    var text: String = "Example"// Fonts
    var fontSize: CGFloat = 0.1 // 0.05 is 50% of container size
    var fontWeight: FontWeight = .regular
    var fontDesign: FontDesign = .default
    var customFontName: String? = nil // In the future the user could add it's own fonts
    var isItalic: Bool = false
    
    // Spacing & more
    var lineLimit: Int = 1
    var letterSpacing: CGFloat = 0.01  // 1% of container
    var lineSpacing: CGFloat = 0.0 // Line spacing
    var strikethrough: Bool = false // Strikethrough decoration
    var strikethroughColor: ColorComponents = ColorComponents(red: 1, green: 0.75, blue: 0.8, alpha: 1)// Color for strikethrough
    var underline: Bool = false // Underline decoration
    var underlineColor: ColorComponents = ColorComponents(red: 1, green: 0.75, blue: 0.8, alpha: 1) // Color for underline
}


extension TextModel {
    static var dataPreviewExample = TextModel(
        fontSize: 0.05,
        fontWeight: .heavy,
        isItalic: true,
        strikethrough: true,
        strikethroughColor: ColorComponents(red: 1, green: 0.75, blue: 0.8, alpha: 1),
        underline: true,
        underlineColor: ColorComponents(red: 1, green: 0.75, blue: 0.8, alpha: 1)
    )
    
    var strikethroughColorComputed: Color {
        get { strikethroughColor.color }
        set { strikethroughColor.setColor(newValue) }
    }
    
    var underlineColorComputed: Color {
        get { underlineColor.color }
        set { underlineColor.setColor(newValue) }
    }
    
    
    //MARK: Finish adding custom fonts from system or user
    /*
     var font: Font {
     if let customFont = customFontName {
     return .custom(customFont, size: fontSize)
     } else if fontStyle != .custom {
     // Use system text style
     return fontStyle.
     } else {
     // Use system font with design
     return .system(size: fontSize, design: fontDesign.swiftUIDesign)
     }
     }
     
     // Get all font families
     let families = UIFont.familyNames.sorted()
     
     // Get specific font names in a family
     for family in families {
     let fonts = UIFont.fontNames(forFamilyName: family)
     print("\(family): \(fonts)")
     }
     */
}
