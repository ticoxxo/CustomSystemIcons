//
//  StarView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 01/04/25.
//

import SwiftUI

struct StarView: View {
    var item: IconModel
    var body: some View {
        Image(systemName: item.isFavorite ? "star.fill" : "star")
            .customAccessibility(label: "Label.Favorite.Accessibility", hint: "Press to add to favorites", isButton: true)
            .foregroundColor(item.isFavorite ? .yellow : .blue)
            .padding([.top, .trailing], 5)
    }
}

#Preview {
    @Previewable @State var item = IconModel()
    StarView(item: item)
}
