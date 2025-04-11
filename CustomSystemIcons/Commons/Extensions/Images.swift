//
//  Images.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 04/04/25.
//

import SwiftUI

extension Image {
    func customAccessibility(label: String, hint: String, isButton: Bool) -> some View {
        let label = NSLocalizedString(label, comment: "")
        let hint = NSLocalizedString(hint, comment: "")
        
        return self
            .accessibilityLabel(Text(label))
            .accessibilityHint(Text(hint))
            .dynamicTypeSize(.large ... .accessibility3)
            .accessibilityAddTraits(isButton ? .isButton : .isImage)
    }
}
