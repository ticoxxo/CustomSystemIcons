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
    var positionX: CGFloat
    var positionY: CGFloat
    var xDistortion: CGFloat
    var yDistortion: CGFloat
    var shadows: ShadowModel
    var isIcon: Bool // if true use Image, false Label
    // Text properties if its a Label
    var textProperties: TextModel
    
    
    init(
        id: UUID = UUID(),
        name: String = "star.fill",
        frontColorComputed: ColorComponents = ColorComponents(color: .black) ,
        orientation: Double = 0.0,
        zoom: Float = 0.5,
        dragging: Bool = false,
        zIndex: Double = 1,
        borderColorComputed: ColorComponents = ColorComponents(red: 1, green: 0.75, blue: 0.8, alpha: 1),  // pink
        positionX: CGFloat = 0.5,
        positionY: CGFloat = 0.5,
        xDistortion: CGFloat = 0.0,
        yDistortion: CGFloat = 0.0,
        shadows: ShadowModel = ShadowModel(),
        isIcon: Bool = true,
        textProperties: TextModel = TextModel()
    ) {
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
        self.xDistortion = xDistortion
        self.yDistortion = yDistortion
        self.shadows = shadows
        self.isIcon = isIcon
        self.textProperties = textProperties
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, frontColorComputed, orientation, zoom, dragging, zIndex, borderColorComputed, positionX, positionY,xDistortion,yDistortion, shadows, weight, textSize, isIcon
    }
}

extension IconChild {
    
    var frontColor: Color {
        get { frontColorComputed.color }
        set { frontColorComputed.setColor(newValue) }
    }
    
    var borderColor: Color {
        get { borderColorComputed.color }
        set { borderColorComputed.setColor(newValue) }
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
