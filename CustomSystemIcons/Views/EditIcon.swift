//
//  EditIcon.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 20/12/24.
//

import SwiftUI
import SFSafeSymbols

struct EditIcon: View {
    @Environment(\.coordinator) var coordinator
    @Binding var vmIcon: SFSymbol
    var body: some View {
        VStack {
            Image(systemSymbol: vmIcon)
                .font(.system(size: 100))
            Text("Edit Icon")
            Button {
                coordinator.popByNumber(2)
            } label: {
               Text("Go Back")
            }
        }
    }
}

#Preview {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @State var vmIcon = IconModel()
    NavigationStack(path: $coordinator.path) {
        EditIcon(vmIcon: $vmIcon.icon)
    }
    .environment(\.coordinator, coordinator)
}

