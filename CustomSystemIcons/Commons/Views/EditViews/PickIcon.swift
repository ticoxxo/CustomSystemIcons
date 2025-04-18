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
    var body: some View {
        
        Image(systemName: "photo")
            .resizable()
            .customAccessibility(label: "Label.ButtonPick.Accessibility", hint:"Label.ButtonPick.Accessibility.Hint", isButton: true)
            .foregroundStyle(item.frontColor)
            .frame(width: 25, height: 25)
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 10))
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            .onTapGesture {
                coordinator.push(page: .GridIconsView(vmIcon: $item))
            }
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
