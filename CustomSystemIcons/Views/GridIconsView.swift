//
//  GridIconsView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 18/12/24.
//

import SwiftUI
import SFSafeSymbols

struct GridIconsView: View {
    @Environment(\.coordinator) var coordinator
    var vm: IconsListModel
    @State private var showDialog: Bool = false
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(spacing: 22), GridItem(spacing: 22), GridItem(spacing: 22)], spacing: 34) {
                ForEach(Array(vm.iconList), id: \.self) { icon in
                    Image(systemSymbol: icon)
                        .font(.system(size: 50))
                        .onTapGesture {
                            //coordinator.push(page: .AddIcon)
                            showDialog.toggle()
                        }
                        .confirmationDialog("Aceptar", isPresented: $showDialog) {
                            Button("Save") {
                            print("Save action")
                            }
                            
                            Button("Update", role: .destructive) {
                            print("Update action")
                            }
                            HStack {
                                
                            }
                        } message: {
                            Text("Use Confirmation Dialogs to present several actions")
                        }
                }
            }
        }
    }
}

#Preview {
    var list = IconsListModel()
    GridIconsView(vm: list)
}
