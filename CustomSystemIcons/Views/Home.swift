//
//  Home.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//

import SwiftUI

struct Home: View {
    @Environment(\.coordinator) var coordinator
    var body: some View {
        VStack {
            Button {
                coordinator.push(page: .AddIcon)
            } label: {
                Image(systemName: "plus.app")
                Text("Add Icon")
            }
            
        }
    }
}

#Preview {
    @Previewable @State var coordinator = Coordinator()
    NavigationStack(path: $coordinator.path) {
        coordinator.build(page: .Home)
            .navigationDestination(for: AppPage.self) { page in
                coordinator.build(page: page)
            }
    }
    .environment(\.coordinator, coordinator)
}
