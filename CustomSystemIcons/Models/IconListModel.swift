//
//  IconModel.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//

import SwiftUI
import SFSafeSymbols
import SwiftData

@Observable
class IconsListModel {
    var _iconList: [String] = []
    var iconList: [String] {
        get {
            let a = SFSymbol.allSymbols
            var array = [] as Array<String>
            a.forEach {
                array.append($0.rawValue)
            }
            return array
        }
        
        set {
            _iconList = newValue
        }
    }
    
    init(){}
    
}

extension IconsListModel {
    
    func returnRandomIcon() -> SFSymbol {
        return SFSymbol.allSymbols.randomElement() ?? SFSymbol.xCircle
    }
    
    func filterIcons(_ searchText: String) {
        if searchText.isEmpty {
            let s =  SFSymbol.allSymbols
            var arr: [String] = []
            s.forEach {
                arr.append($0.rawValue)
            }
            iconList = arr
        } else {
            iconList = iconList.filter { symbol in
                symbol.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
}
