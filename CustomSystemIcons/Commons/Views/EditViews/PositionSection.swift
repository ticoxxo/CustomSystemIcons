//
//  PositionSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 27/02/25.
//

import SwiftUI

struct PositionSection: View {
    @Bindable var vmIcon: IconModel
    @State private var expanded: Bool = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            ForEach($vmIcon.icons) { item in
                HStack {
                    Image(systemName: item.name.wrappedValue)
                        .resizable()
                        .foregroundStyle(item.frontColor.wrappedValue)
                        .frame(width: 25, height: 25)
                    Slider(value: item.zoom, in:0.2...1.0)
                        .customAccessibilityFloat(label: "Slider.Zoom.Accessibility", hint: "Slide to change icon zoom", value: item.zoom)
                }
                
            }
        } label: {
            Text("Manual zoom").font(.headline)
                .customAccessibility(label: "Label manual zoom", hint: "Title for zoom manual section")
        }
    }
}


#Preview {
    @Previewable @State var vmIcon = IconModel()
    //vmIcon.icons.append(IconChild())
    //vmIcon.icons.append(IconChild())
    vmIcon.addIcon()
    vmIcon.addIcon()
    return PositionSection(vmIcon: vmIcon)
}
