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
            Grid(alignment: .leading) {
                GridRow {
                    Text("ColorPicker.BorderColor")
                        .lineLimit(1)
                    CompactSliderColorPicker(selectedColor: $vmIcon.borderColor)
                    ColorPicker("ColorPicker.BorderColor", selection: $vmIcon.borderColor)
                        .customAccessibility(label: "ColorPicker.BorderColor.Accessibility", hint: "ColorPicker.BorderColor.Accessibility.Hint")
                        .labelsHidden()
                        
                }
                
                GridRow {
                    Text("Label.Width")
                        .lineLimit(1)
                    Slider(value: $vmIcon.borderWidth, in:0.0...0.09)
                        .customAccessibilityCGFloat(label: "Slider.BorderWidth.Accessibility", hint: "Slider.BorderWidth.Accessibility.Hint", value: $vmIcon.borderWidth)
                        .tint(MyColor.skyblue.value)
                }
                
                GridRow {
                    /*
                    Text("Label.CornerRadius")
                        .lineLimit(1)
                    Slider(value: $vmIcon.cornerRadio, in:0.0...0.09)
                        .customAccessibilityCGFloat(label: "Slider.CornerRadius.Accessibility", hint: "Slider.CornerRadius.Accessibility.Hint", value: $vmIcon.cornerRadio)
                        .onChange(of: vmIcon.cornerRadio) {
                            vmIcon.styleShape = vmIcon.styleShape.withRadio(vmIcon.cornerRadio)
                        }
                        .tint(MyColor.skyblue.value)
                     */
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

#Preview("Ipad") {
    @Previewable @State var vmIcon = IconModel()
    //vmIcon.icons.append(IconChild())
    //vmIcon.icons.append(IconChild())
    vmIcon.addIcon()
    vmIcon.addIcon()
    return BorderSection(vmIcon: vmIcon)
}
