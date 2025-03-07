//
//  StyleShape.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 25/02/25.
//
import SwiftUI

enum StyleShape: Int,CaseIterable , Codable, Shape {
    
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
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        switch self {
        case .star:
            return createStar(corners: 5, smoothness: 0.45, path: &path, center: center, rect: rect)
        case .circle:
            path.addEllipse(in: CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height))
            path.closeSubpath()
        case .square:
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        case .triangle:
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()
        case .hexagone:
            return createStar(corners: 6, smoothness: 0.6, path: &path, center: center, rect: rect)
        case .gearshape:
            return createStar(corners: 8, smoothness: 0.6, path: &path, center: center, rect: rect)
        }
        return path
    }
    
    case star = 0
    case circle = 1
    case square = 2
    case triangle = 3
    case hexagone = 4
    case gearshape = 5
}
