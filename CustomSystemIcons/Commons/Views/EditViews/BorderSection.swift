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
                ColorPicker("Border Color", selection: $vmIcon.borderColor)
                    .customAccessibility(label: "Color in Border Section", hint: "Choose a color for the border")
                    .lineLimit(1)
            }
            HStack {
                Text("Width")
                    .lineLimit(1)
                Slider(value: $vmIcon.borderWidth, in:0.0...0.1)
                    .customAccessibilityDouble(label: "Slider in Border Section", hint: "Slide to change the width of the border", value: $vmIcon.borderWidth)
                    
            }
        } label: {
            Text("Border").font(.headline)
                .customAccessibility(label: "Border name for the form section", hint: "Name of the group")
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
