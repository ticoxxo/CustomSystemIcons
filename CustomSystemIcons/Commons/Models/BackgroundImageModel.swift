//
//  BackgroundImageModel.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 08/04/25.
//
import SwiftUI
import SwiftData

@Model
final class BackgroundImageModel {
    @Attribute(.externalStorage) var backgroundImage: Data?
    var zoom: Float
    var orientation: Double
    @Transient var dragging: Bool = false
    var positionX: Double
    var positionY: Double
    
    init(
        backgroundImage: Data? = nil,
        zoom: Float = 1.0,
        orientation: Double = 0.0,
        dragging: Bool = false,
        positionX: Double = 0.0,
        positionY: Double = 0.0
    ) {
        self.backgroundImage = backgroundImage
        self.zoom = zoom
        self.orientation = orientation
        self.dragging = dragging
        self.positionX = positionX
        self.positionY = positionY
    }
    
    enum CodingKeys: String, CodingKey {
        case backgroundImage,zoom,orientation,dragging,positionX,positionY
    }
    
}
