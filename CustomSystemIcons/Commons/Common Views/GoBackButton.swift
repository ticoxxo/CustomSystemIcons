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
            Label("Go Back", systemImage: "arrow.left")
                
        }
        .customAccessibility(label: "Button.Back.Accessibility", hint: "Press to go back to the previous screen")
        .foregroundColor(Color.blue)
    }
}

#Preview {
    GoBackButton()
}
