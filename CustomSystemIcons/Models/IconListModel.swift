//
//  IconModel.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//
import SwiftUI
import SFSafeSymbols

@Observable
class IconsListModel {
    var iconList: Set<SFSymbol> = SFSymbol.allSymbols
    var arrayOfIcons : [IconModel] = []
    
    init() {
    }
    
}

extension IconsListModel {
    
    func returnRandomIcon() -> SFSymbol {
        return SFSymbol.allSymbols.randomElement() ?? SFSymbol.xCircle
    }
    
    func filterIcons(_ searchText: String) {
        if searchText.isEmpty {
            iconList = SFSymbol.allSymbols
        } else {
            iconList = iconList.filter { symbol in
                symbol.rawValue.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func agregarTarea(_ tarea: IconModel) {
        arrayOfIcons.append(tarea)
    }
    
}
