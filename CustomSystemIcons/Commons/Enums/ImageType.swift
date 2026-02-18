//
//  ImageType.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 28/03/25.
//

enum ImageType: String, CaseIterable,Identifiable {
    case png
    case jpeg
    case ico
    //case svg
    var id: String { rawValue }
    
    var displayName: String {
        rawValue.uppercased()
    }
}


enum ImageSize: Int, CaseIterable, Identifiable {
    case small = 64
    case medium = 128
    case large = 256
    case xlarge = 512
    case xxlarge = 1024
    case xxxlarge = 2048
    
    var id: Int { rawValue }
    
    var displayName: String {
        "\(rawValue)×\(rawValue)"
    }
    
    
}

extension ImageSize {
    static func availableSizes(for imageType: ImageType) -> [ImageSize] {
        switch imageType {
        case .ico: [.small, .medium, .large]
        case .jpeg, .png: ImageSize.allCases
        }
    }
}
