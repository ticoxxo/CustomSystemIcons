//
//  TextModel.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 30/01/26.
//
import SwiftUI
import SwiftData

struct TextModel: Codable, Hashable, Equatable {
    // Fonts
    var fontSize: CGFloat = 0.2 // 20% of container size
    var fontWeight: FontWeight = .light
    var fontDesign: FontDesign = .default
    var fontStyle: FontStyle = .custom
    var customFontName: String? = nil
    var isItalic: Bool = false
    
    // Spacing & more
    var lineLimit: Int = 1
    var letterSpacing: CGFloat = 0.01  // 1% of container
    var lineSpacing: CGFloat = 0.0 // Line spacing
    var strikethrough: Bool = false // Strikethrough decoration
    var strikethroughColor: ColorComponents // Color for strikethrough
    var underline: Bool // Underline decoration
    var underlineColor: ColorComponents // Color for underline
}


extension TextModel {
    static var dataPreviewExample = TextModel(
        fontSize: 18,
        fontWeight: .heavy,
        isItalic: true,
        strikethrough: true,
        strikethroughColor: ColorComponents(red: 1, green: 0.75, blue: 0.8, alpha: 1),
        underline: true,
        underlineColor: ColorComponents(red: 1, green: 0.75, blue: 0.8, alpha: 1)
    )
    
    
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
