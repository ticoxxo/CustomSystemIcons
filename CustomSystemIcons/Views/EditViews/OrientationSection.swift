//
//  OrientationSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 06/03/25.
//

import SwiftUI

struct OrientationSection: View {
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
                    Slider(
                        value: item.orientation,
                        in: 0.0...99.99
                    )
                }
            }
        } label: {
            Text("Orientation").font(.headline)
            
        }
    }
}

#Preview {
    @Previewable @State var vmIcon = IconModel()
    //vmIcon.icons.append(IconChild())
    //vmIcon.icons.append(IconChild())
    vmIcon.addIcon()
    vmIcon.addIcon()
    return OrientationSection(vmIcon: vmIcon)
}
