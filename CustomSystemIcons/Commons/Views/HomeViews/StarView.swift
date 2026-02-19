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
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(item.isFavorite ? .yellow : .blue)
            
    }
}

#Preview {
    @Previewable @State var item = IconModel()
    StarView(item: item)
}
