//
//  Path.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 24/04/25.
//

import SwiftUI


extension Path {
    mutating func addRoundedPolygon(points: [CGPoint], cornerRadius: CGFloat) {
        guard points.count > 2 else { return }
        
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
                move(to: start)
            } else {
                addLine(to: start)
            }
            
            addQuadCurve(to: end, control: current)
        }
        
        closeSubpath()
    }
}
