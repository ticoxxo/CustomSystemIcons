//
//  Text.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 03/04/25.
//
import SwiftUI

extension Text {
    func customAccessibility(label: String, hint: String) -> some View {
        let label = NSLocalizedString(label, comment: "")
        let hint = NSLocalizedString(hint, comment: "")
        
        return self.accessibilityLabel(Text(label))
            .accessibilityHint(Text(hint))
            .dynamicTypeSize(.large ... .accessibility3)
    }
}
