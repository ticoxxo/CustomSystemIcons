//
//  GoBackButton.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 31/03/25.
//

import SwiftUI

struct GoBackButton: View {
    @Environment(\.coordinator) var coordinator
    
    var body: some View {
        Button {
            coordinator.toRoot()
        } label: {
            Label("Label.GoBack", systemImage: "arrow.left")
                
        }
        .customAccessibility(label: "Button.Back.Accessibility", hint: "Button.Back.Accessibility.Hint")
        .foregroundColor(Color.blue)
    }
}

#Preview {
    GoBackButton()
}
