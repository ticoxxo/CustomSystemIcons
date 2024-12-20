//
//  Coordinator.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//
import SwiftUI

@Observable
class Coordinator {
    var path: NavigationPath = NavigationPath()
    var sheet: Sheet?
    
    // Pages
    func push(page: AppPage) {
        path.append(page)
    }
        
    func pop() {
        path.removeLast()
    }
    
    func toRoot() {
        path.removeLast(path.count)
    }
    
    // Sheet
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
        
    @ViewBuilder
    func build(page: AppPage) -> some View {
        switch page {
        case .home: Home()
        case .AddIcon: AddIcon()
        }
    }
    
    @ViewBuilder
    func buildSheet(sheet: Sheet) -> some View {
        switch sheet {
        case .showIconsList: IconsSheetList()
        }
    }
    
}
