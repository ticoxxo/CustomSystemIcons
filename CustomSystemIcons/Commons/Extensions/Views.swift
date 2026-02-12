//
//  Views.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 12/02/26.
//

import SwiftUI

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
