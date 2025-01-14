//
//  ConfirmationDialogView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 20/12/24.
//

import SwiftUI

struct ConfirmationDialogView: View {
    @Environment(\.coordinator) var coordinator
    var body: some View {
        VStack {
            Button {
                //coordinator.push(page: )
            } label: {
                Text("Si")
            }
        }
    }
}

#Preview {
    ConfirmationDialogView()
}
