//
//  ShadowSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 23/04/25.
//

import SwiftUI

struct ShadowSection: View {
    @Bindable var vmIcon: IconModel
    @State private var expanded: Bool = true // change to false
    @ScaledMetric private var iconSize: CGFloat = 25
    
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
        
            Grid(alignment: .leading) {
                GridRow {
                    vmIcon.shape
                        .stroke(vmIcon.borderColor, lineWidth: vmIcon.borderWidth * iconSize)
                        .fill(vmIcon.backgroundColor)
                        .frame(width: iconSize, height: iconSize)
                    ShadowControls(shadow: $vmIcon.shadows)
                    CustomColorPicker(color: $vmIcon.shadows.shadowColor)
                }
                
                ForEach($vmIcon.icons) { item in
                    GridRow {
                        Image(systemName: item.name.wrappedValue)
                            .resizable()
                            .foregroundStyle(item.frontColor.wrappedValue)
                            .frame(width: iconSize, height: iconSize)
                        
                        ShadowControls(shadow: item.shadows)
                        
                        CustomColorPicker(color: item.shadows.shadowColor)
                    }
                }
            }
           
            
        } label: {
            Text("Label.Shadows").font(.headline)
                .customAccessibility(label: "Label.Shadows.Accessibility", hint: "")
        }
    }
    
}

private struct ShadowControls: View {
    @Binding var shadow: ShadowModel
    var body: some View {
        HStack {
            VStack {
                Slider(value: $shadow.radius, in: 0...10)
                    .tint(MyColor.skyblue.value)
                Text("Lbl.Shadows.Radius")
            }
            VStack {
                Slider(value: $shadow.shadowX, in: 0...10)
                    .tint(MyColor.skyblue.value)
                Text("Lbl.Shadows.AxisX")
            }
            VStack {
                Slider(value: $shadow.shadowY, in: 0...10)
                    .tint(MyColor.skyblue.value)
                Text("Lbl.Shadows.AxisY")
            }
            VStack {
                Slider(value: $shadow.opacity, in: 0...10)
                    .tint(MyColor.skyblue.value)
                Text("Lbl.Shadows.Opacity")
            }
        }
    }
}

#Preview {
    @Previewable @State var vmIcon = IconModel()
    vmIcon.borderWidth = 0.8
    vmIcon.icons.append(IconChild())
    vmIcon.icons.append(IconChild())
    return ShadowSection(vmIcon: vmIcon)
}
