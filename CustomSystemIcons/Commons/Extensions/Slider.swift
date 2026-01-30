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
        let formattedValue = FormattedNumber(value: value.wrappedValue)
        
        return self
            .accessibilityLabel(Text(label))
            .accessibilityHint(Text(hint))
            .accessibilityValue(Text(LocalizedStringResource("Slider.Value.\(formattedValue)")))
            .accessibilityElement(children: .combine)
    }
    
    func customAccessibilityFloat(label: String, hint: String, value: Binding<Float>) -> some View {
        let label = NSLocalizedString(label, comment: "")
        let hint = NSLocalizedString(hint, comment: "")
        let formattedValue = FormattedNumber(value: Double(value.wrappedValue))
        
        return self
            .accessibilityLabel(Text(label))
            .accessibilityHint(Text(hint))
            .accessibilityValue(Text(LocalizedStringResource("Slider.Value.\(formattedValue)")))
            .accessibilityElement(children: .combine)
    }
    
    func customAccessibilityCGFloat(label: String, hint: String, value: Binding<CGFloat>) -> some View {
        let label = NSLocalizedString(label, comment: "")
        let hint = NSLocalizedString(hint, comment: "")
        let formattedValue = FormattedNumber(value: Double(value.wrappedValue))
        
        return self
            .accessibilityLabel(Text(label))
            .accessibilityHint(Text(hint))
            .accessibilityValue(Text(LocalizedStringResource("Slider.Value.\(formattedValue)")))
            .accessibilityElement(children: .combine)
    }
    
}

/// A wrapper for numeric values that can be interpolated in LocalizedStringResource
struct FormattedNumber: CustomLocalizedStringResourceConvertible {
    let value: Double
    
    var localizedStringResource: LocalizedStringResource {
        // Format the number with 2 decimal places for consistent localization
        let formatted = String(format: "%.2f", value)
        return LocalizedStringResource(stringLiteral: formatted)
    }
}
