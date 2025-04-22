//
//  Distortion.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 22/04/25.
//
import SwiftUI

struct DistortionEffect: GeometryEffect {
    var xDistortion: CGFloat
    var yDistortion: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        let xOffset = xDistortion * size.width
        let yOffset = yDistortion * size.height

        let transform = CGAffineTransform(
            a: 1, b: yOffset / size.height,
            c: xOffset / size.width, d: 1,
            tx: 0, ty: 0
        )
        return ProjectionTransform(transform)
    }
}
