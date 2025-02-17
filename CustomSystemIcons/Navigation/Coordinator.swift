//
//  Coordinator.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//
import SwiftUI
import SFSafeSymbols

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
    
    func popByNumber(_ number: Int) {
        path.removeLast(number)
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
        case .Home: Home()
        case .AddIcon(let vmIcon): AddIcon(vmIcon: vmIcon)
        case .EditIcon(let vmIcon): EditIcon(vmIcon: vmIcon)
        case .GridIconsView(let vmIcon): GridIconsView(vmIcon: vmIcon)
        case .DateView(let date, let title): DateView(date: date, title: title)
        }
    }
    
    @ViewBuilder
    func buildSheet(sheet: Sheet) -> some View {
        switch sheet {
        case .showIconsList: IconsSheetList()
        }
    }
    
}
