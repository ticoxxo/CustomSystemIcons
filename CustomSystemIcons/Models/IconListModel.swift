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
    private let allSymbolsArray: [SFSymbol]
    private let symbolStrings: [String]
    
    var symbolsList: [SFSymbol]
    
    init() {
        self.allSymbolsArray = Array(SFSymbol.allSymbols)
        self.symbolStrings = allSymbolsArray.map { $0.rawValue.lowercased() }
        self.symbolsList = allSymbolsArray
    }
    
    func search(_ query: String) {
        guard !query.isEmpty else {
            symbolsList = allSymbolsArray
            return
        }
        
        let queryLowercased = query.lowercased()
        
        let filtered = symbolStrings.enumerated().compactMap { index, string in
            string.contains(queryLowercased) ? index : nil
        }
        
        symbolsList = filtered.map { allSymbolsArray[$0] }
    }

    func returnRandomIcon() -> SFSymbol {
        return SFSymbol.allSymbols.randomElement() ?? SFSymbol.xCircle
    }
    
}


