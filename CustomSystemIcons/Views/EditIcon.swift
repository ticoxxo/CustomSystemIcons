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
                .symbolRenderingMode(.palette)
                .foregroundStyle(
                    .linearGradient(colors: [.red, .black,.green], startPoint: .top, endPoint: .bottomTrailing),
                    .linearGradient(colors: [.green, .black,.green], startPoint: .top, endPoint: .bottomTrailing),
                        .linearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottomTrailing)
                    )
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

