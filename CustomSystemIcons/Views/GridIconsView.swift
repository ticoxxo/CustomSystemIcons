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
    @State var iconsList: IconsListModel = IconsListModel()
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    @Binding var vmIcon: IconChild
    @State var searchText: String = ""
    var filteredIcons: [String] {
            if searchText.isEmpty {
                return iconsList.iconList
            } else {
                return iconsList.iconList.filter { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
    var body: some View {
        VStack {
            HStack {
                Spacer()
                TextField("Search icon...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity)
                Spacer()
            }
            .padding()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(filteredIcons, id: \.self) { icon in
                        Image(systemName: "\(icon)")
                            .resizable()
                            .scaledToFit()
                            .onTapGesture {
                                vmIcon.name = icon
                                coordinator.pop()
                            }
                    }
                    .onChange(of: searchText){
                        iconsList.filterIcons(searchText)
                    }
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                GoBackButton()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    @Previewable @State var coordinator = Coordinator()
    @Previewable let list = IconsListModel().iconList
    @Previewable @State var vmIcon = IconChild()
    NavigationStack(path: $coordinator.path) {
        GridIconsView(vmIcon: $vmIcon)
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
