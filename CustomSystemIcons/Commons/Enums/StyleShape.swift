//
//  StyleShape.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 25/02/25.
//
import SwiftUI

enum StyleShape:  Shape, Codable, Hashable {
   
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
    
    
    func createStar(corners: Int, smoothness: Double, center: CGPoint, rect: CGRect, cornerRadius: CGFloat) -> Path {
        
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

        let path = addRoundedPolygon(points: points, cornerRadius: cornerRadius)
        return path.applying(transform)
    }
    
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        switch self {
        case .star(let radio):
            return createStar(corners: 5, smoothness: 0.45,  center: center, rect: rect, cornerRadius: radio)
        case .circle:
            var path = Path()
            path.addEllipse(in: CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height))
            path.closeSubpath()
            return path
        case .square(let radio):
            var path = Path()
            let roundedRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height)
            path.addRoundedRect(in: roundedRect, cornerSize: CGSize(width: radio, height: radio))
            path.closeSubpath()
            return path
        case .triangle(let radio):
            
            let points = [
                            CGPoint(x: rect.midX, y: rect.minY),
                            CGPoint(x: rect.minX, y: rect.maxY),
                            CGPoint(x: rect.maxX, y: rect.maxY)
                        ]
            return addRoundedPolygon(points: points, cornerRadius: radio)
        case .hexagon(let radio):
            return createStar(corners: 6, smoothness: 0.6,  center: center, rect: rect, cornerRadius: radio)
        case .gearshape(let radio):
            return createStar(corners: 8, smoothness: 0.6,  center: center, rect: rect, cornerRadius: radio)
        }
        
    }
    
    func withRadio(_ newValue: CGFloat) -> StyleShape {
        switch self {
        case .star: return .star(radio: newValue)
        case .square: return .square(radio: newValue)
        case .triangle: return .triangle(radio: newValue)
        case .hexagon: return .hexagon(radio: newValue)
        case .gearshape: return .gearshape(radio: newValue)
        case .circle: return .circle
        }
    }
    
    func addRoundedPolygon(points: [CGPoint], cornerRadius: CGFloat) -> Path {
        var path = Path()
        
        for i in 0..<points.count {
            let current = points[i]
            let previous = points[(i - 1 + points.count) % points.count]
            let next = points[(i + 1) % points.count]
            
            let previousVector = CGVector(dx: current.x - previous.x, dy: current.y - previous.y)
            let nextVector = CGVector(dx: next.x - current.x, dy: next.y - current.y)
            
            let previousLength = sqrt(previousVector.dx * previousVector.dx + previousVector.dy * previousVector.dy)
            let nextLength = sqrt(nextVector.dx * nextVector.dx + nextVector.dy * nextVector.dy)
            
            let previousOffset = min(cornerRadius, previousLength / 2)
            let nextOffset = min(cornerRadius, nextLength / 2)
            
            let start = CGPoint(
                x: current.x - previousVector.dx / previousLength * previousOffset,
                y: current.y - previousVector.dy / previousLength * previousOffset
            )
            
            let end = CGPoint(
                x: current.x + nextVector.dx / nextLength * nextOffset,
                y: current.y + nextVector.dy / nextLength * nextOffset
            )
            
            if i == 0 {
                path.move(to: start)
            } else {
                path.addLine(to: start)
            }
            
            path.addQuadCurve(to: end, control: current)
        }
        
        path.closeSubpath()
        return path
    }
}

