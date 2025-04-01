//
//  BorderSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 10/03/25.
//

import SwiftUI

struct BorderSection: View {
    @Bindable var vmIcon: IconModel
    @State private var expanded: Bool = false
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            HStack {
                Text("Color").lineLimit(1)
                ColorPicker("Border Color", selection: $vmIcon.borderColor)
            }
            HStack {
                Text("Width").lineLimit(1)
                Slider(value: $vmIcon.borderWidth, in:0.0...0.1)
            }
        } label: {
            Text("Border").font(.headline)
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
