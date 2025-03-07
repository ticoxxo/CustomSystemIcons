//
//  IconChild.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 25/02/25.
//
import SwiftUI
import SwiftData

@Model
class IconChild: Identifiable {
    var id: UUID = UUID()
    var name: String
    var frontColorComputed: Colores
    var orientation: Double
    var zoom: CGFloat
    var position: CGPoint
    var dragging: Bool
    var zIndex: Double
    var offset: CGSize
    
    init(name: String = "star.fill",
         frontColorComputed: Colores = .init(red: Double.random(in: 0.09...0.9),blue: Double.random(in: 0.09...0.9),green:Double.random(in: 0.09...0.9)),
         orientation: Double = 0.0,
         zoom: CGFloat = 0.8,
         position: CGPoint = .zero,
         dragging: Bool = false,
         zIndex: Double = 1,
         offset: CGSize = .zero) {
        self.name = name
        self.frontColorComputed = frontColorComputed
        self.orientation = orientation
        self.zoom = zoom
        self.position = position
        self.dragging =  dragging
        self.zIndex = zIndex
        self.offset = offset
    }
}

extension IconChild {
    var frontColor: Color {
        get { Color(red: frontColorComputed.red, green: frontColorComputed.green, blue: frontColorComputed.blue)}
        set {
            if let components = newValue.cgColor?.components {
                frontColorComputed.red = components[0]
                frontColorComputed.green = components[1]
                frontColorComputed.blue = components[2]
            }
        }
    }
    
    func changePosition(width: CGFloat, height: CGFloat) -> CGPoint {
        if (self.position == .zero) {
            self.position.x = width / 2
            self.position.y = height / 2
        }
        
        return self.position
    }
    
    func randomColor() -> Double {
        Double.random(in: 0.1...100)
    }
}
