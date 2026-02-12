//
//  CustomColorPicker.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 12/02/26.
//
import SwiftUI

struct CustomColorPicker: View {
    @Binding var color: Color
    var body: some View {
        ColorPicker("ColorPicker.BorderColor", selection: $color)
            .labelsHidden()
    }
}


/*
 .customAccessibility(label: "ColorPicker.BorderColor.Accessibility", hint: "ColorPicker.BorderColor.Accessibility.Hint")
 */
