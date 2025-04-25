//
//  StyleShape.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 25/02/25.
//
import SwiftUI

enum StyleShape:  Shape, Codable, Hashable {
   
    
    /*
    static var allCases: [StyleShape] = [
        .circle,
        .square(radio: 0),
        .triangle(radio: 0),
        .hexagon(radio: 0),
        .gearshape(radio: 0),
        .star(radio: 0)
    ]
     */
    
    case star(radio: CGFloat)
        case circle
        case square(radio: CGFloat)
        case triangle(radio: CGFloat)
        case hexagon(radio: CGFloat)
        case gearshape(radio: CGFloat)

        var rawValue: String {
            switch self {
            case .star: return "star"
            case .circle: return "circle"
            case .square: return "square"
            case .triangle: return "triangle"
            case .hexagon: return "hexagon"
            case .gearshape: return "gearshape"
            }
        }
    
}

extension StyleShape {
    
    static func allCases(with radio: CGFloat) -> [StyleShape] {
        return [
            .circle,
                        .square(radio: radio),
                        .triangle(radio: radio),
                        .hexagon(radio: radio),
                        .gearshape(radio: radio),
                        .star(radio: radio)
        ]
    }
    
    mutating func updateRadio(to newValue: CGFloat) {
        switch self {
                case .star:
                    self = .star(radio: newValue)
                case .square:
                    self = .square(radio: newValue)
                case .triangle:
                    self = .triangle(radio: newValue)
                case .hexagon:
                    self = .hexagon(radio: newValue)
                case .gearshape:
                    self = .gearshape(radio: newValue)
                case .circle:
                    // Circle does not have a radio parameter, so no update is needed
                    break
                }
    }
    
    func createStar(corners: Int, smoothness: Double, path: inout Path, center: CGPoint, rect: CGRect, cornerRadius: CGFloat) -> Path {
        var currentAngle = -CGFloat.pi / 2
        let angleAdjustment = .pi * 2 / Double(corners * 2)
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness
        var points: [CGPoint] = []

        for corner in 0..<corners * 2 {
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let point: CGPoint

            if corner.isMultiple(of: 2) {
                point = CGPoint(x: center.x * cosAngle, y: center.y * sinAngle)
            } else {
                point = CGPoint(x: innerX * cosAngle, y: innerY * sinAngle)
            }

            points.append(point)
            currentAngle += angleAdjustment
        }

        let unusedSpace = (rect.height / 2 - points.map { $0.y }.max()!) / 2
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)

        path.addRoundedPolygon(points: points, cornerRadius: cornerRadius)
        return path.applying(transform)
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        switch self {
        case .star(let radio):
            return createStar(corners: 5, smoothness: 0.45, path: &path, center: center, rect: rect, cornerRadius: radio)
        case .circle:
            path.addEllipse(in: CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height))
            path.closeSubpath()
        case .square(let radio):
           
            let roundedRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height)
            path.addRoundedRect(in: roundedRect, cornerSize: CGSize(width: radio, height: radio))
        case .triangle(let radio):
            
            let points = [
                            CGPoint(x: rect.midX, y: rect.minY),
                            CGPoint(x: rect.minX, y: rect.maxY),
                            CGPoint(x: rect.maxX, y: rect.maxY)
                        ]
            path.addRoundedPolygon(points: points, cornerRadius: radio)
        case .hexagon(let radio):
            return createStar(corners: 6, smoothness: 0.6, path: &path, center: center, rect: rect, cornerRadius: radio)
        case .gearshape(let radio):
            return createStar(corners: 8, smoothness: 0.6, path: &path, center: center, rect: rect, cornerRadius: radio)
        }
        return path
    }
}


/*
 func createStar(corners: Int, smoothness: Double, path: inout Path, center: CGPoint, rect: CGRect) -> Path {
     
     var currentAngle = -CGFloat.pi / 2
     
     let angleAdjustment = .pi * 2 / Double(corners * 2)
     let innerX = center.x * smoothness
     let innerY = center.y * smoothness
     path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))
     var bottomEdge: Double = 0
     for corner in 0..<corners * 2  {
         let sinAngle = sin(currentAngle)
         let cosAngle = cos(currentAngle)
         let bottom: Double
         
         if corner.isMultiple(of: 2) {
             bottom = center.y * sinAngle
             
             path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
         } else {
             bottom = innerY * sinAngle
             
             path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
         }
         
         if bottom > bottomEdge {
             bottomEdge = bottom
         }
         
         currentAngle += angleAdjustment
     }

     let unusedSpace = (rect.height / 2 - bottomEdge) / 2

     let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
     path.closeSubpath()
     return path.applying(transform)
 }
 
 */
