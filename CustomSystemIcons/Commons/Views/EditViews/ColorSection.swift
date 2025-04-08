//
//  ColorSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 27/02/25.
//

import SwiftUI

struct ColorSection: View {
    @Environment(\.coordinator) var coordinator
    @Bindable var vmIcon: IconModel
    @State private var expanded: Bool = true
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            HStack {
                ColorPicker("Background color", selection: $vmIcon.backgroundColor)
                    .customAccessibility(label: "Background color picker", hint: "Pick a color for the background")
            }
            List {
                ForEach($vmIcon.icons.sorted { $0.zIndex.wrappedValue < $1.zIndex.wrappedValue }) { icon in
                    HStack {
                        Text("\(Int(icon.zIndex.wrappedValue))")
                        Image(systemName: "\(icon.name.wrappedValue)")
                            .resizable()
                            .customAccessibility(label: "Icon button", hint: "Press to select the a new icon", isButton: true)
                            .foregroundStyle(icon.frontColor.wrappedValue)
                            .frame(width: 25, height: 25)
                        
                        PickIcon(item: icon)
                        ColorPicker("Pick a color for the icon", selection: icon.frontColor)
                            .customAccessibility(label: "Background color picker", hint: "Pick a color for the icon")
                        
                    }
                    .deleteDisabled(vmIcon.icons.count < 2)
                }
                .onMove(perform: vmIcon.moveRow)
                .onDelete(perform: vmIcon.removeIcon)
            }
            
        } label: {
            Text("Background and layers")
                .customAccessibility(label: "lbl.layers", hint: "Title for background and layers section")
                .font(.headline)
        }
    }
}

#Preview {
    @Previewable @State var vmIcon = IconModel()
    vmIcon.icons.append(IconChild())
    vmIcon.icons.append(IconChild())
    vmIcon.icons[1].zIndex = 2.0
    vmIcon.icons[2].zIndex = 3.0
    return ColorSection(vmIcon: vmIcon)
}
