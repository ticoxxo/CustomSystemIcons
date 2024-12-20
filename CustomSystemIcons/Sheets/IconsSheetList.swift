//
//  IconsSheetList.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 17/12/24.
//

import SwiftUI
import SFSafeSymbols

struct IconsSheetList: View {
    @Environment(\.coordinator) var coordinator
    @State private var vm = IconsListModel()
    @State private var icono: SFSymbol?
    var body: some View {
        GridIconsView(vm: vm)
    }
}

#Preview {
    IconsSheetList()
}
