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
                Text("Background and layers").lineLimit(1)
                ColorPicker("", selection: $vmIcon.backgroundColor)
            }
            List {
                ForEach($vmIcon.icons.sorted { $0.zIndex.wrappedValue < $1.zIndex.wrappedValue }) { icon in
                    HStack {
                        Text("\(Int(icon.zIndex.wrappedValue))")
                        Image(systemName: "\(icon.name.wrappedValue)")
                            .resizable()
                            .foregroundStyle(icon.frontColor.wrappedValue)
                            .frame(width: 25, height: 25)
                        PickIcon(item: icon)
                        ColorPicker("", selection: icon.frontColor)
                        
                    }
                }
                .onMove(perform: vmIcon.moveRow)
                .onDelete(perform: vmIcon.removeIcon)
            }
            
        } label: {
            Text("Colors").font(.headline)
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
