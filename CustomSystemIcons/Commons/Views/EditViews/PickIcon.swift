//
//  PickIcon.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 10/03/25.
//

import SwiftUI

struct PickIcon: View {
    @Environment(\.coordinator) var coordinator
    @Binding var item: IconChild
    @State private var expanded: Bool = true
    @ScaledMetric private var iconSize = 25.0
    var body: some View {
        
        Button {
            coordinator.push(page: .GridIconsView(vmIcon: $item))
        } label: {
            Image(systemName: "photo.badge.plus.fill")
                .resizable()
                .scaledToFill()
                .foregroundStyle(item.frontColor)
                .frame(width: iconSize, height: iconSize)
        }
        .buttonStyle(.automatic)
    }
}

#Preview {
    @Previewable @State var vmIcon = IconModel()
    //vmIcon.icons.append(IconChild())
    //vmIcon.icons.append(IconChild())
    //return PickIcon(vmIcon: vmIcon)
    @Previewable @State var coordinator = Coordinator()
    NavigationStack(path: $coordinator.path) {
        PickIcon(item: $vmIcon.icons[0])
    }
    .environment(\.coordinator, coordinator)
}
