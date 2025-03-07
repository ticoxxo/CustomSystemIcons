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
    @State private var set: Set<String> = ["value1", "value2", "value3", "value4"]

    //@Binding var vmIcon: SFSymbol
    @Bindable var vmIcon: IconModel
    @State var searchText: String = ""
    var body: some View {
        VStack {

            TextField("Buscar...", text: $searchText)
            ScrollView {
                if iconsList.iconList.isEmpty {
                    Text("No hay iconos")
                } else {
                    LazyVGrid(columns: [GridItem(spacing: 22), GridItem(spacing: 22), GridItem(spacing: 22)], spacing: 34) {
                        /*
                         ForEach(Array(iconsList.iconList), id: \.self) { icon in
                             Image(systemName: "\(icon.rawValue)")
                                 .font(.system(size: 50))
                                 .onTapGesture {
                                     let d = icon.rawValue
                                     vmIcon.icon = d
                                     coordinator.push(page: .EditIcon(vmIcon: $vmIcon))
                                 }
                         }
                         */
                        ForEach($iconsList.iconList, id: \.self) { $element in
                            Image(systemName: "\(element)")
                                .font(.system(size: 50))
                                .onTapGesture {
                                    
                                    //vmIcon.iconSF = element
                                    coordinator.push(page: .EditIcon(vmIcon: vmIcon))
                                }
                        }
                        .onChange(of: searchText){
                            iconsList.filterIcons(searchText)
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
        GridIconsView(vmIcon: vmIcon)
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
