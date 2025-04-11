//
//  Slider.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 07/04/25.
//
import SwiftUI

extension Slider {
    func customAccessibilityDouble(label: String, hint: String, value: Binding<Double>) -> some View {
        let label = NSLocalizedString(label, comment: "")
        let hint = NSLocalizedString(hint, comment: "")
        
        return self
            .accessibilityLabel(Text(label))
            .accessibilityHint(Text(hint))
            .accessibilityValue(Text("\(value) in slider"))
            .accessibilityElement(children: .combine)
    }
    
    func customAccessibilityFloat(label: String, hint: String, value: Binding<Float>) -> some View {
        let label = NSLocalizedString(label, comment: "")
        let hint = NSLocalizedString(hint, comment: "")
        
        return self
            .accessibilityLabel(Text(label))
            .accessibilityHint(Text(hint))
            .accessibilityValue(Text("\(value) in slider"))
            .accessibilityElement(children: .combine)
    }
    
}
