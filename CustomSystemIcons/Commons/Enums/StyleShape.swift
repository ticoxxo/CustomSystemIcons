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
    
    
    func createStar(corners: Int, smoothness: Double, rect: CGRect, cornerRadius: CGFloat) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        var currentAngle = -CGFloat.pi / 2
        let angleAdjustment = .pi * 2 / Double(corners * 2)
        let innerRadius = radius * smoothness
        var points: [CGPoint] = []

        for corner in 0..<corners * 2 {
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let point: CGPoint
            
            if corner.isMultiple(of: 2) {
                point = CGPoint(
                    x: center.x + radius * cosAngle,
                    y: center.y + radius * sinAngle
                )
            } else {
                point = CGPoint(
                    x: center.x + innerRadius * cosAngle,
                    y: center.y + innerRadius * sinAngle
                )
            }
            
            points.append(point)
            currentAngle += angleAdjustment
        }
        
        return addRoundedPolygon(points: points, cornerRadius: cornerRadius)
    }
    
    func path(in rect: CGRect) -> Path {
        let minDimension = min(rect.width, rect.height)
        
        switch self {
        case .star(let radioPercentage):
            let scaledRadius = minDimension * radioPercentage
            return createStar(corners: 5, smoothness: 0.45, rect: rect, cornerRadius: scaledRadius)
            
        case .circle:
            var path = Path()
            path.addEllipse(in: rect)
            path.closeSubpath()
            return path
            
        case .square(let radioPercentage):
            var path = Path()
            let scaledRadius = minDimension * radioPercentage
            path.addRoundedRect(in: rect, cornerSize: CGSize(width: scaledRadius, height: scaledRadius))
            path.closeSubpath()
            return path
            
        case .triangle(let radioPercentage):
            let scaledRadius = minDimension * radioPercentage
            let points = [
                CGPoint(x: rect.midX, y: rect.minY),
                CGPoint(x: rect.minX, y: rect.maxY),
                CGPoint(x: rect.maxX, y: rect.maxY)
            ]
            return addRoundedPolygon(points: points, cornerRadius: scaledRadius)
            
        case .hexagon(let radioPercentage):
            let scaledRadius = minDimension * radioPercentage
            return createStar(corners: 6, smoothness: 0.6, rect: rect, cornerRadius: scaledRadius)
            
        case .gearshape(let radioPercentage):
            let scaledRadius = minDimension * radioPercentage
            return createStar(corners: 8, smoothness: 0.6, rect: rect, cornerRadius: scaledRadius)
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
        guard points.count > 2 else {
            return Path() // Need at least 3 points for a polygon
        }
        
        var path = Path()
        let pointCount = points.count
        
        for i in 0..<pointCount {
            let current = points[i]
            let previous = points[(i - 1 + pointCount) % pointCount]
            let next = points[(i + 1) % pointCount]
            
            // Calculate edge vectors
            let toPrevious = CGVector(dx: previous.x - current.x, dy: previous.y - current.y)
            let toNext = CGVector(dx: next.x - current.x, dy: next.y - current.y)
            
            // Calculate edge lengths
            let lengthToPrevious = sqrt(toPrevious.dx * toPrevious.dx + toPrevious.dy * toPrevious.dy)
            let lengthToNext = sqrt(toNext.dx * toNext.dx + toNext.dy * toNext.dy)
            
            // Avoid division by zero
            guard lengthToPrevious > 0, lengthToNext > 0 else { continue }
            
            // Normalize vectors
            let unitToPrevious = CGVector(dx: toPrevious.dx / lengthToPrevious, dy: toPrevious.dy / lengthToPrevious)
            let unitToNext = CGVector(dx: toNext.dx / lengthToNext, dy: toNext.dy / lengthToNext)
            
            // Calculate safe offset (can't be more than half the edge length)
            let maxOffset = min(cornerRadius, lengthToPrevious / 2, lengthToNext / 2)
            
            // Calculate start and end points of the curve
            let startPoint = CGPoint(
                x: current.x + unitToPrevious.dx * maxOffset,
                y: current.y + unitToPrevious.dy * maxOffset
            )
            
            let endPoint = CGPoint(
                x: current.x + unitToNext.dx * maxOffset,
                y: current.y + unitToNext.dy * maxOffset
            )
            
            // Build path
            if i == 0 {
                path.move(to: startPoint)
            } else {
                path.addLine(to: startPoint)
            }
            
            path.addQuadCurve(to: endPoint, control: current)
        }
        
        path.closeSubpath()
        return path
    }
    
   
}

/*
extension StyleShape: InsettableShape {
    func inset(by amount: CGFloat) -> some InsettableShape {
        _Inset(shape: self, amount: amount)
    }
    
    private struct _Inset: InsettableShape {
        var shape: StyleShape
        var amount: CGFloat
        
        func path(in rect: CGRect) -> Path {
            // Calculate the outer rect (before inset) to get the original corner radius
            let outerRect = rect.insetBy(dx: -amount, dy: -amount)
            let outerMinDimension = min(outerRect.width, outerRect.height)
            
            // Get the radio percentage from the shape
            let radioPercentage: CGFloat
            switch shape {
            case .star(let radio):
                radioPercentage = radio
            case .square(let radio):
                radioPercentage = radio
            case .triangle(let radio):
                radioPercentage = radio
            case .hexagon(let radio):
                radioPercentage = radio
            case .gearshape(let radio):
                radioPercentage = radio
            case .circle:
                radioPercentage = 0
            }
            
            // Calculate absolute corner radius from outer dimensions
            let absoluteCornerRadius = outerMinDimension * radioPercentage
            
            // Inset the rect
            let insetRect = rect.insetBy(dx: amount, dy: amount)
            let insetMinDimension = min(insetRect.width, insetRect.height)
            
            // Prevent division by zero
            guard insetMinDimension > 0 else {
                return Path()
            }
            
            // Convert absolute corner radius back to percentage for the inset rect
            let adjustedRadioPercentage = absoluteCornerRadius / insetMinDimension
            
            // Create the path with adjusted percentage
            switch shape {
            case .star:
                let adjustedShape = StyleShape.star(radio: adjustedRadioPercentage)
                return adjustedShape.path(in: insetRect)
                
            case .circle:
                var path = Path()
                path.addEllipse(in: insetRect)
                return path
                
            case .square:
                let adjustedShape = StyleShape.square(radio: adjustedRadioPercentage)
                return adjustedShape.path(in: insetRect)
                
            case .triangle:
                let adjustedShape = StyleShape.triangle(radio: adjustedRadioPercentage)
                return adjustedShape.path(in: insetRect)
                
            case .hexagon:
                let adjustedShape = StyleShape.hexagon(radio: adjustedRadioPercentage)
                return adjustedShape.path(in: insetRect)
                
            case .gearshape:
                let adjustedShape = StyleShape.gearshape(radio: adjustedRadioPercentage)
                return adjustedShape.path(in: insetRect)
            }
        }
        
        func inset(by amount: CGFloat) -> some InsettableShape {
            _Inset(shape: shape, amount: self.amount + amount)
        }
    }
}

*/
/*
 
 private struct _Inset: InsettableShape {
     var shape: StyleShape
     var amount: CGFloat
     
     func path(in rect: CGRect) -> Path {
         let insetRect = rect.insetBy(dx: amount, dy: amount)
         return shape.path(in: insetRect)
     }
     
     func inset(by amount: CGFloat) -> some InsettableShape {
         _Inset(shape: shape, amount: self.amount + amount)
     }
 }
 */
