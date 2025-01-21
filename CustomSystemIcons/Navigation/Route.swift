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
        case (.AddIcon, .AddIcon):
            return true
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
            case .AddIcon:
                hasher.combine(1)
            case .EditIcon(let vmIcon ):
                hasher.combine(vmIcon.id)
            case .GridIconsView(let vmIcon):
                hasher.combine(vmIcon.id)
            }
        }
    
    
    case Home
    case AddIcon
    case EditIcon(vmIcon: Binding<IconModel>)
    case GridIconsView(vmIcon: Binding<IconModel>)
}

