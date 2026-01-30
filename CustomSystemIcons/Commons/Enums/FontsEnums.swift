//
//  FontsEnums.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 30/01/26.
//
import SwiftUI

enum FontWeight: Int,Codable, Hashable {
    case ultraLight = 100
        case thin = 200
        case light = 300
        case regular = 400
        case medium = 500
        case semibold = 600
        case bold = 700
        case heavy = 800
        case black = 900
        
        var rawValue: Font.Weight {
            switch self {
            case .ultraLight: return .ultraLight
            case .thin: return .thin
            case .light: return .light
            case .regular: return .regular
            case .medium: return .medium
            case .semibold: return .semibold
            case .bold: return .bold
            case .heavy: return .heavy
            case .black: return .black
            }
        }
}

enum FontDesign: String, Codable, Hashable {
    case `default` = "default"
    case serif = "serif"
    case rounded = "rounded"
    case monospaced = "monospaced"
    
    var swiftUIDesign: Font.Design {
        switch self {
        case .default: return .default
        case .serif: return .serif
        case .rounded: return .rounded
        case .monospaced: return .monospaced
        }
    }
}

enum FontStyle: String, Codable, Hashable {
    case largeTitle = "largeTitle"
    case title = "title"
    case title2 = "title2"
    case title3 = "title3"
    case headline = "headline"
    case body = "body"
    case callout = "callout"
    case subheadline = "subheadline"
    case footnote = "footnote"
    case caption = "caption"
    case caption2 = "caption2"
    case custom = "custom"  // Use fontSize instead
}
