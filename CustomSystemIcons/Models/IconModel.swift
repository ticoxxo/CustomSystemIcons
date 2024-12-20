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
    
    func returnRandomIcon() -> SFSymbol {
        return SFSymbol.allSymbols.randomElement() ?? SFSymbol.xCircle
    }
 
}

