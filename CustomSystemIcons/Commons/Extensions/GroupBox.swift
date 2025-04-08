//
//  GroupBox.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 05/04/25.
//
import SwiftUI

extension GroupBox {
    func customAccessibility(label: String, hint: String) -> some View {
        let label = NSLocalizedString(label, comment: "")
        let hint = NSLocalizedString(hint, comment: "")
        return self.accessibilityLabel(Text(label))
            .accessibilityHint(Text(hint))
            .accessibilityAddTraits(.isHeader)
    }
}
