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
    let iconsList = IconsListModel().iconList
    @Binding var vmIcon: SFSymbol
    //@State private var selectedIcon: SFSymbol?
    var body: some View {
        VStack {
            Text("Selected icon: \(Image(systemSymbol: vmIcon))")
            ScrollView {
                LazyVGrid(columns: [GridItem(spacing: 22), GridItem(spacing: 22), GridItem(spacing: 22)], spacing: 34) {
                    ForEach(Array(iconsList), id: \.self) { icon in
                        Image(systemSymbol: icon)
                            .font(.system(size: 50))
                            .onTapGesture {
                                vmIcon = icon
                                coordinator.push(page: .EditIcon(vmIcon: $vmIcon))
                            }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var coordinator = Coordinator()
    @Previewable let list = IconsListModel().iconList
    @Previewable @State var vmIcon = IconModel()
    NavigationStack(path: $coordinator.path) {
        GridIconsView(vmIcon: $vmIcon.icon)
    }
    .environment(\.coordinator, coordinator)
}

/*
 @Previewable @State var coordinator = Coordinator()
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
 */
