//
//  HomeIconView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 21/03/25.
//

import SwiftUI

struct HomeIconView: View {
    var vmIcon: IconModel
    var body: some View {
        Rectangle()
            .fill(Color.red)
            .overlay {
                IconView(vmIcon: vmIcon, editable: false)
            }
    }
}

#Preview {
    @Previewable @State var vmIcon = IconModel()
    HomeIconView(vmIcon: vmIcon)
}
