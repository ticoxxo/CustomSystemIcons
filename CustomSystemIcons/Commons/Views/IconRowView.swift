//
//  IconRowView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 22/01/25.
//

import SwiftUI

struct IconRowView: View {
    @Bindable var icon: IconModel
    var widtho = UIScreen.current?.bounds.size.width ?? 0
    var heighto = UIScreen.current?.bounds.size.height ?? 0
    var body: some View {
        VStack {
            
            Rectangle()
                .overlay {
                    IconView(vmIcon: icon,
                             bWidth: min(widtho, heighto) / 6,
                             bHeight: min(widtho, heighto) / 6,
                             editable: false)
                }
                .foregroundStyle(Color.gray)
                .frame(width: min(widtho, heighto) / 3 ,
                       height:  min(widtho, heighto) / 3)
                Text(icon.tareaName)
                .lineLimit(1)
                .font(.footnote)
            
        }
    }
}

#Preview {
    @Previewable @State var icon = IconModel(title: "Noisita ggg titulo muuuy largo largo", tareaName: "Gatita preciosa bonita")
    IconRowView(icon: icon)
}
