//
//  BorderSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 10/03/25.
//
// TODO: Keep adding accessibility labels to all views.
import SwiftUI

struct BorderSection: View {
    @Bindable var vmIcon: IconModel
    @State private var expanded: Bool = false
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            HStack {
                ColorPicker("ColorPicker.BorderColor", selection: $vmIcon.borderColor)
                    .customAccessibility(label: "ColorPicker.BorderColor.Accessibility", hint: "ColorPicker.BorderColor.Accessibility.Hint")
                    .lineLimit(1)
            }
            HStack {
                Text("Label.Width")
                    .lineLimit(1)
                Slider(value: $vmIcon.borderWidth, in:0.01...0.1)
                    .customAccessibilityDouble(label: "Slider.BorderWidth.Accessibility", hint: "Slider.BorderWidth.Accessibility.Hint", value: $vmIcon.borderWidth)
                    
            }
            
            HStack {
                Text("Label.CornerRadius")
                    .lineLimit(1)
                Slider(value: $vmIcon.cornerRadio, in:0.0...20)
                    .customAccessibilityCGFloat(label: "Slider.CornerRadius.Accessibility", hint: "Slider.CornerRadius.Accessibility.Hint", value: $vmIcon.cornerRadio)
                    .onChange(of: vmIcon.cornerRadio) {
                        vmIcon.styleShape.updateRadio(to: vmIcon.cornerRadio)
                    }
                    
            }
        } label: {
            Text("Label.Border").font(.headline)
                .customAccessibility(label: "Label.Border.Accessibility", hint: "Label.Border.Accessibility.Hint")
        }
    }
}

#Preview {
    @Previewable @State var vmIcon = IconModel()
    //vmIcon.icons.append(IconChild())
    //vmIcon.icons.append(IconChild())
    vmIcon.addIcon()
    vmIcon.addIcon()
    return BorderSection(vmIcon: vmIcon)
}
