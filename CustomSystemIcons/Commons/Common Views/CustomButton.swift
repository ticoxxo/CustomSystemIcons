//
//  CustomButton.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 02/04/25.
//

import SwiftUI

struct CustomButton: ButtonStyle {
    var color: Color
    var width: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        let horizontal = horizontalPadding * 0.04
        let vertical = verticalPadding * 0.01
        configuration.label
            .padding(EdgeInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal))
            .font(.title)
            .lineLimit(1)
            .minimumScaleFactor(0.4)
            .labelStyle(.automatic)
            .fontWeight(.bold)
            .background(color)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .overlay(
                Capsule(style: .continuous)
                    .stroke(Color.white, lineWidth: horizontalPadding * 0.01)
                    .glow(color: .gray, radius: 15)
            )
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
                        .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .frame(maxWidth: width)
            //x: 20, y: 20
    }
}

#Preview {
    Button {
        
    } label: {
        Label("Add button", systemImage: "plus")
    }
    .buttonStyle(CustomButton(color: MyColor.skyblue.value, width: 500))
}
