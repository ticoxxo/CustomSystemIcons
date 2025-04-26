//
//  ShadowSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 23/04/25.
//

import SwiftUI

struct ShadowSection: View {
    @Bindable var vmIcon: IconModel
    @State private var expanded: Bool = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
        
            HStack {
                Text("Lbl.Principal")
                VStack {
                    Slider(value: $vmIcon.shadows.radius, in: 0...10)
                        .customAccessibilityCGFloat(label: "Slider.Shadows.Accessibility", hint: "Slider.Shadows.Accessibility.Hint", value: $vmIcon.shadows.radius)
                        .tint(MyColor.skyblue.value)
                    Text("Lbl.Shadows.Radius")
                }
                VStack {
                    Slider(value: $vmIcon.shadows.shadowX, in: 0...10)
                        .customAccessibilityCGFloat(label: "Slider.ShadowsX.Accessibility", hint: "Slider.ShadowsX.Accessibility.Hint", value: $vmIcon.shadows.shadowX)
                        .tint(MyColor.skyblue.value)
                    Text("Lbl.Shadows.AxisX")
                }
                VStack {
                    Slider(value: $vmIcon.shadows.shadowY, in: 0...10)
                        .customAccessibilityCGFloat(label: "Slider.ShadowsY.Accessibility", hint: "Slider.ShadowsY.Accessibility.Hint", value: $vmIcon.shadows.shadowY)
                        .tint(MyColor.skyblue.value)
                    Text("Lbl.Shadows.AxisY")
                }
                VStack {
                    Slider(value: $vmIcon.shadows.opacity, in: 0...10)
                        .customAccessibilityCGFloat(label: "Slider.Opacity.Accessibility", hint: "Slider.Opacity.Accessibility.Hint", value: $vmIcon.shadows.shadowY)
                        .tint(MyColor.skyblue.value)
                    Text("Lbl.Shadows.Opacity")
                }
                ColorPicker("", selection: $vmIcon.shadows.shadowColor)
                    .customAccessibility(label: "ColorPicker.Shadows.Accessibility", hint: "ColorPicker.Shadows.Accessibility.Hint")
            }
            
            ForEach($vmIcon.icons) { item in
                HStack {
                    Image(systemName: item.name.wrappedValue)
                        .resizable()
                        .foregroundStyle(item.frontColor.wrappedValue)
                        .frame(width: 25, height: 25)
                    VStack {
                        Slider(value: item.shadows.radius, in: 0...10)
                            .customAccessibilityCGFloat(label: "Slider.Shadows.Accessibility", hint: "Slider.Shadows.Accessibility.Hint", value: item.shadows.radius)
                            .tint(MyColor.skyblue.value)
                        Text("Lbl.Shadows.Radius")
                            
                    }
                    VStack {
                        Slider(value: item.shadows.shadowX, in: 0...10)
                            .customAccessibilityCGFloat(label: "Slider.ShadowsX.Accessibility", hint: "Slider.ShadowsX.Accessibility.Hint", value: item.shadows.shadowX)
                            .tint(MyColor.skyblue.value)
                        Text("Lbl.Shadows.AxisX")
                    }
                    VStack {
                        Slider(value: item.shadows.shadowY, in: 0...10)
                            .customAccessibilityCGFloat(label: "Slider.ShadowsY.Accessibility", hint: "Slider.ShadowsY.Accessibility.Hint", value: item.shadows.shadowY)
                            .tint(MyColor.skyblue.value)
                        Text("Lbl.Shadows.AxisY")
                    }
                    
                    VStack {
                        Slider(value: item.shadows.opacity, in: 0...10)
                            .customAccessibilityCGFloat(label: "Slider.Opacity.Accessibility", hint: "Slider.Opacity.Accessibility.Hint", value: item.shadows.shadowY)
                            .tint(MyColor.skyblue.value)
                        Text("Lbl.Shadows.Opacity")
                            
                    }
                    ColorPicker("", selection: item.shadows.shadowColor)
                        .customAccessibility(label: "ColorPicker.Shadows.Accessibility", hint: "ColorPicker.Shadows.Accessibility.Hint")
                        .tint(MyColor.skyblue.value)
                }
            }
            
        } label: {
            Text("Label.Shadows").font(.headline)
                .customAccessibility(label: "Label.Shadows.Accessibility", hint: "")
        }
    }
}

#Preview {
    @Previewable @State var vmIcon = IconModel()
    vmIcon.icons.append(IconChild())
    vmIcon.icons.append(IconChild())
    return ShadowSection(vmIcon: vmIcon)
}
