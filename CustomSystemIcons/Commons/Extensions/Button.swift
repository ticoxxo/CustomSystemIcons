//
//  Button.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 05/04/25.
//
import SwiftUI

extension Button {
    func customAccessibility(label: String, hint: String) -> some View {
        let label = NSLocalizedString(label, comment: "")
        let hint = NSLocalizedString(hint, comment: "")
        
        return self
            .accessibilityElement(children: .combine)
            .accessibilityLabel(Text(label))
            .accessibilityHint(Text(hint))
            .dynamicTypeSize(.large ... .accessibility3)
            .accessibilityAddTraits(.isButton)
    }
}
