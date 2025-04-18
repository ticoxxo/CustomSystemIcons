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
        case (.AddIcon(let lhIcon, let lhAddIcon), .AddIcon(let rhIcon, let rhAddIcon)):
            return  lhIcon.id == rhIcon.id && lhAddIcon == rhAddIcon
        case (.EditIcon(let lhVmIcon), .EditIcon(let rhVmIcon)):
            return lhVmIcon.id == rhVmIcon.id
        case (.GridIconsView(let lhVmIcon), .GridIconsView(let rhVmIcon)):
            return lhVmIcon.id == rhVmIcon.id
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .Home:
            hasher.combine(0)
        case .AddIcon(let icon, let addMode):
            hasher.combine(icon.id)
            hasher.combine(addMode.hashValue)
        case .EditIcon(let vmIcon ):
            hasher.combine(vmIcon.id)
        case .GridIconsView(let vmIcon):
            hasher.combine(vmIcon.id)
        }
    }
    
    
    case Home
    case AddIcon(vmIcon: IconModel, addMode: Bool)
    case EditIcon(vmIcon: IconModel)
    case GridIconsView(vmIcon: Binding<IconChild>)
}

