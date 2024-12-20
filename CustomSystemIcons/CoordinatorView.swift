//
//  ContentView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//

import SwiftUI

struct CoordinatorView: View {
    @State private var coordinator = Coordinator()
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .home)
                .navigationDestination(for: AppPage.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet ) { sheet in
                    coordinator.buildSheet(sheet: sheet)
                }
            
        }
            .environment(\.coordinator, coordinator)
    }
}

#Preview {
    CoordinatorView()
        .environment(\.coordinator, Coordinator())
}
