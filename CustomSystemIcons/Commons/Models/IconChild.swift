//
//  IconChild.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 25/02/25.
//
import SwiftUI
import SwiftData

@Model
final class IconChild: Identifiable {
    var id: UUID
    var name: String
    var frontColorComputed: ColorComponents
    var orientation: Double
    var zoom: Float
    @Transient var dragging: Bool = false
    var zIndex: Double
    var borderColorComputed: ColorComponents
    var positionX: Double
    var positionY: Double
    
    init(
        id: UUID = UUID(),
        name: String = "star.fill",
        frontColorComputed: ColorComponents = ColorComponents(color: .yellow),
         orientation: Double = 0.0,
         zoom: Float = 1.0,
         dragging: Bool = false,
         zIndex: Double = 1,
        borderColorComputed: ColorComponents = ColorComponents(color: .pink),
        positionX: Double = 0.0,
        positionY: Double = 0.0) {
             self.id = id
        self.name = name
        self.frontColorComputed = frontColorComputed
        self.orientation = orientation
        self.zoom = zoom
        self.dragging =  dragging
        self.zIndex = zIndex
        self.borderColorComputed = borderColorComputed
            self.positionX = positionX
            self.positionY = positionY
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, frontColorComputed, orientation, zoom, dragging, zIndex, borderColorComputed, positionX, positionY, styleShape
    }
}

extension IconChild {
    var frontColor: Color {
        get { frontColorComputed.color }
        set { frontColorComputed = ColorComponents(color: newValue) }
    }
    
    var borderColor: Color {
        get { borderColorComputed.color }
        set { borderColorComputed = ColorComponents(color: newValue) }
    }
    
    /*
    func changePosition(width: CGFloat, height: CGFloat) -> CGPoint {
        if (self.position == .zero) {
            self.position.x = width / 2
            self.position.y = height / 2
        }
        
        return self.position
    }
     */
    
    func randomColor() -> Double {
        Double.random(in: 0.1...100)
    }
 
}
