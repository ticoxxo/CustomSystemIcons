//
//  ListRowView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 01/04/25.
//

import SwiftUI

struct ListRowView: View {
    var item: IconModel
    var body: some View {
        VStack {
            IconView(vmIcon: item, bWidth: 100, bHeight: 100,editable: false)
            Text("\(item.title)")
                .font(.footnote)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    @Previewable @State var item = IconModel(title: "Titulo")
    ListRowView(item: item)
}
