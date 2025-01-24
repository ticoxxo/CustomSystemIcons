//
//  Route.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//
import SFSafeSymbols
import SwiftUI

enum AppPage: Hashable, Equatable {
    
    static func ==(lhs: AppPage, rhs: AppPage) -> Bool {
        switch (lhs, rhs) {
        case (.Home, .Home):
            return true
        case (.AddIcon(let lhList, let lhIcon), .AddIcon(let rhList, let rhIcon)):
            return lhList.arrayOfIcons.wrappedValue == rhList.arrayOfIcons.wrappedValue && lhIcon.id == rhIcon.id
        case (.EditIcon(let lhVmIcon), .EditIcon(let rhVmIcon)):
            return lhVmIcon.id == rhVmIcon.id
        case (.GridIconsView(let lhVmIcon), .GridIconsView(let rhVmIcon)):
            return lhVmIcon.id == rhVmIcon.id
        case (.DateView(let lhDate, let lhTitle), .DateView(let rhDate, let rhTitle)):
            return lhDate.wrappedValue == rhDate.wrappedValue && lhTitle == rhTitle
        default:
            return false
                }
    }
    
    func hash(into hasher: inout Hasher) {
            switch self {
            case .Home:
                hasher.combine(0)
            case .AddIcon(let list, let icon):
                hasher.combine(list.arrayOfIcons.wrappedValue)
                hasher.combine(icon.id)
            case .EditIcon(let vmIcon ):
                hasher.combine(vmIcon.id)
            case .GridIconsView(let vmIcon):
                hasher.combine(vmIcon.id)
            case .DateView(let date, let title):
                hasher.combine(date.wrappedValue)
                hasher.combine(title.hashValue)
            }
        }
    
    
    case Home
    case AddIcon(list: Binding<IconsListModel>, vmIcon: Binding<IconModel>)
    case EditIcon(vmIcon: Binding<IconModel>)
    case GridIconsView(vmIcon: Binding<IconModel>)
    case DateView(date: Binding<Date>, title: String)
}

