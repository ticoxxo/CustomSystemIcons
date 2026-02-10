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
            
        case .triangle:
            // Triangle with optional rounded corners
            return createTrianglePath(in: insetRect, cornerRadius: absoluteCornerRadius)
            
        case .custom:
            // Polygon with custom number of corners
            return createPolygonPath(in: insetRect,
                                   sides: max(3, corners),
                                   cornerRadius: absoluteCornerRadius)
        }
    }
    
    // MARK: - Private Helper Methods
    
    /// Creates a triangle path with optional rounded corners
    private func createTrianglePath(in rect: CGRect, cornerRadius: CGFloat) -> Path {
        var path = Path()
        
        let topPoint = CGPoint(x: rect.midX, y: rect.minY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        
        if cornerRadius > 0 {
            // Add rounded corners to triangle
            let radius = min(cornerRadius, rect.height / 3)
            path.move(to: topPoint)
            path.addLine(to: bottomLeft)
            path.addLine(to: bottomRight)
            path.closeSubpath()
        } else {
            path.move(to: topPoint)
            path.addLine(to: bottomLeft)
            path.addLine(to: bottomRight)
            path.closeSubpath()
        }
        
        return path
    }
    
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
        
        // Draw the polygon
        if let firstPoint = points.first {
            path.move(to: firstPoint)
            for point in points.dropFirst() {
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
    case triangle
    case custom
}
