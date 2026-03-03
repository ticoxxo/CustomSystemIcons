//
//  Figura.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 09/02/26.
//
import SwiftUI

struct Figura: InsettableShape, Codable {
    var cornerRadio: CGFloat = 0.0
    var selectedPath: FiguraSelected = .rectangle
    var corners: Int = 6
    var insetAmount: CGFloat = 0.0
    var innerRadiusRatio: CGFloat = 0.4
    
    func path(in rect: CGRect) -> Path {
        // Apply the inset to the rect
        let insetRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        
        // Calculate corner radius based on the inset rect dimensions
        let minDimension = min(insetRect.width, insetRect.height)
        let absoluteCornerRadius = max(0, min(minDimension * cornerRadio, minDimension / 2))
        
        switch selectedPath {
        case .circle:
            // Circle case: ignores corner radius as it's already fully rounded
            return Path(ellipseIn: insetRect)
            
        case .rectangle:
            // Rectangle with rounded corners
            return Path(roundedRect: insetRect,
                       cornerRadius: absoluteCornerRadius)
            
        case .star:
            // Triangle with optional rounded corners
            return  createStarPath(in: insetRect,
                                         points: max(3, corners),
                                         cornerRadius: absoluteCornerRadius)
        case .custom:
            // Polygon with custom number of corners
            return createPolygonPath(in: insetRect,
                                   sides: max(3, corners),
                                   cornerRadius: absoluteCornerRadius)
        }
    }
    
    // MARK: - Private Helper Methods
    
    
    
    /// Creates a regular polygon path with the specified number of sides
    /// Creates a regular polygon path with the specified number of sides
    private func createPolygonPath(in rect: CGRect, sides: Int, cornerRadius: CGFloat) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        // Calculate the angle between each vertex
        let angleIncrement = (2 * CGFloat.pi) / CGFloat(sides)
        // Start from the top (-π/2 to have first point at top)
        let startAngle = -CGFloat.pi / 2
        
        // Generate vertices
        var points: [CGPoint] = []
        for i in 0..<sides {
            let angle = startAngle + angleIncrement * CGFloat(i)
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            points.append(CGPoint(x: x, y: y))
        }
        
        guard let firstPoint = points.first else { return path }
        
        if cornerRadius > 0 {
            // Draw polygon with rounded corners
            for i in 0..<points.count {
                let current = points[i]
                let next = points[(i + 1) % points.count]
                let previous = points[(i - 1 + points.count) % points.count]
                
                // Calculate vectors
                let v1 = CGPoint(x: current.x - previous.x, y: current.y - previous.y)
                let v2 = CGPoint(x: next.x - current.x, y: next.y - current.y)
                
                // Normalize vectors
                let length1 = sqrt(v1.x * v1.x + v1.y * v1.y)
                let length2 = sqrt(v2.x * v2.x + v2.y * v2.y)
                
                let normalized1 = CGPoint(x: v1.x / length1, y: v1.y / length1)
                let normalized2 = CGPoint(x: v2.x / length2, y: v2.y / length2)
                
                // Calculate control points for the curve
                let effectiveRadius = min(cornerRadius, length1 / 2, length2 / 2)
                
                let startPoint = CGPoint(
                    x: current.x - normalized1.x * effectiveRadius,
                    y: current.y - normalized1.y * effectiveRadius
                )
                
                let endPoint = CGPoint(
                    x: current.x + normalized2.x * effectiveRadius,
                    y: current.y + normalized2.y * effectiveRadius
                )
                
                if i == 0 {
                    path.move(to: startPoint)
                } else {
                    path.addLine(to: startPoint)
                }
                
                path.addQuadCurve(to: endPoint, control: current)
            }
            path.closeSubpath()
        } else {
            // Draw polygon without rounded corners
            path.move(to: firstPoint)
            for point in points.dropFirst() {
                path.addLine(to: point)
            }
            path.closeSubpath()
        }
        
        return path
    }
    
    /// Creates a star path with the specified number of points
    private func createStarPath(in rect: CGRect, points: Int, cornerRadius: CGFloat) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * innerRadiusRatio// Inner radius is 40% of outer radius
        
        // Calculate the angle between each point
        let angleIncrement = CGFloat.pi / CGFloat(points)
        let startAngle = -CGFloat.pi / 2
        
        // Generate vertices (alternating between outer and inner points)
        var vertices: [CGPoint] = []
        for i in 0..<(points * 2) {
            let angle = startAngle + angleIncrement * CGFloat(i)
            let radius = i % 2 == 0 ? outerRadius : innerRadius
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            vertices.append(CGPoint(x: x, y: y))
        }
        
        guard let firstPoint = vertices.first else { return path }
        
        if cornerRadius > 0 {
            // Draw star with rounded corners
            for i in 0..<vertices.count {
                let current = vertices[i]
                let next = vertices[(i + 1) % vertices.count]
                let previous = vertices[(i - 1 + vertices.count) % vertices.count]
                
                // Calculate vectors
                let v1 = CGPoint(x: current.x - previous.x, y: current.y - previous.y)
                let v2 = CGPoint(x: next.x - current.x, y: next.y - current.y)
                
                // Normalize vectors
                let length1 = sqrt(v1.x * v1.x + v1.y * v1.y)
                let length2 = sqrt(v2.x * v2.x + v2.y * v2.y)
                
                let normalized1 = CGPoint(x: v1.x / length1, y: v1.y / length1)
                let normalized2 = CGPoint(x: v2.x / length2, y: v2.y / length2)
                
                // Calculate control points for the curve
                let effectiveRadius = min(cornerRadius, length1 / 2, length2 / 2)
                
                let startPoint = CGPoint(
                    x: current.x - normalized1.x * effectiveRadius,
                    y: current.y - normalized1.y * effectiveRadius
                )
                
                let endPoint = CGPoint(
                    x: current.x + normalized2.x * effectiveRadius,
                    y: current.y + normalized2.y * effectiveRadius
                )
                
                if i == 0 {
                    path.move(to: startPoint)
                } else {
                    path.addLine(to: startPoint)
                }
                
                path.addQuadCurve(to: endPoint, control: current)
            }
            path.closeSubpath()
        } else {
            // Draw star without rounded corners
            path.move(to: firstPoint)
            for point in vertices.dropFirst() {
                path.addLine(to: point)
            }
            path.closeSubpath()
        }
        
        return path
    }
    
    // InsettableShape conformance
        func inset(by amount: CGFloat) -> some InsettableShape {
            var figura = self
            figura.insetAmount += amount
            return figura
        }
}

enum FiguraSelected: Codable {
    case circle
    case rectangle
    case star
    case custom
    
    var value: String {
        switch self {
        case .circle : return "Circle"
        case .rectangle: return "Rectangle"
        case .star: return "Star"
        case .custom: return "Custom"
        }
    }
}
