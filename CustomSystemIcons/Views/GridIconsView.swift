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
    @State var iconsList = IconsListModel()
    @Binding var vmIcon: SFSymbol
    @State var searchText: String = ""
    var body: some View {
        VStack {
            Text("Selected icon: \(Image(systemSymbol: vmIcon))")
            TextField("Buscar...", text: $searchText)
            ScrollView {
                LazyVGrid(columns: [GridItem(spacing: 22), GridItem(spacing: 22), GridItem(spacing: 22)], spacing: 34) {
                    ForEach(Array(iconsList.iconList), id: \.self) { icon in
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
        .onChange(of: searchText){
            iconsList.filterIcons(searchText)
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
