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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.isPhone) private var isPhone
    
    var hidePicker: Bool {
        horizontalSizeClass == .compact
    }
    
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            Grid(alignment: .leading) {
                GridRow {
                    Text("ColorPicker.BorderColor")
                        .lineLimit(1)

                    colorSection
                        
                }
                
                GridRow {
                    Text("Label.Width")
                        .lineLimit(1)
                    Slider(value: $vmIcon.borderWidth, in:0.0...0.09)
                        .customAccessibilityCGFloat(label: "Slider.BorderWidth.Accessibility", hint: "Slider.BorderWidth.Accessibility.Hint", value: $vmIcon.borderWidth)
                        .tint(MyColor.skyblue.value)
                }
                
                GridRow {
                    
                    Text("Label.CornerRadius")
                        .lineLimit(1)
                    Slider(value: $vmIcon.shape.cornerRadio, in:0.0...0.09)
                        .tint(MyColor.skyblue.value)
                     
                }
                
                GridRow {
                    
                    Text("Label.InnerRadio")
                        .lineLimit(1)
                    Slider(value: $vmIcon.shape.innerRadiusRatio, in:0.2...0.9)
                        .tint(MyColor.skyblue.value)
                     
                }
                
            }
            
            
        } label: {
            Text("Label.Border").font(.headline)
                .customAccessibility(label: "Label.Border.Accessibility", hint: "Label.Border.Accessibility.Hint")
        }
    }
    
    @ViewBuilder
    var colorSection: some View {
        if horizontalSizeClass == .regular {
            CompactSliderColorPicker(selectedColor: $vmIcon.borderColor)
            CustomColorPicker(color: $vmIcon.borderColor)
        }
        
        if horizontalSizeClass == .compact {
            HStack {
                Spacer()
                    .frame(maxWidth: .infinity)
                CustomColorPicker(color: $vmIcon.borderColor)
                Spacer()
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview("Landscape", traits: .landscapeLeft) {
    @Previewable @State var vmIcon = IconModel()
    //vmIcon.icons.append(IconChild())
    //vmIcon.icons.append(IconChild())
    vmIcon.addIcon()
    vmIcon.addIcon()
    return BorderSection(vmIcon: vmIcon)
}

#Preview("Portrait") {
    @Previewable @State var vmIcon = IconModel()
    //vmIcon.icons.append(IconChild())
    //vmIcon.icons.append(IconChild())
    vmIcon.addIcon()
    vmIcon.addIcon()
    return BorderSection(vmIcon: vmIcon)
}
