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
                //coordinator.dismissSheet()
            } label: {
                Image(systemName: "plus.app")
                Text("Add Icon")
            }
            
            Button {
                coordinator.presentSheet(.showIconsList)
            } label: {
                Text("Show icons sheet")
            }
        }
    }
}

#Preview {
    @Previewable @State var path = Coordinator()
    NavigationStack(path: $path.path) {
        Home()
            
    }
}
