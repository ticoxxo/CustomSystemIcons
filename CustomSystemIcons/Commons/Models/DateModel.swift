//
//  DateModel.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 23/01/25.
//
import SwiftUI

struct DateModel {
    let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
    
    func hour() -> Int {
        components.hour ?? 0
    }
}
