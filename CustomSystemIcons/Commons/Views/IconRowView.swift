//
//  IconRowView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 22/01/25.
//

import SwiftUI

struct IconRowView: View {
    @Bindable var icon: IconModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(icon.title)")
                .font(.largeTitle)
            HStack {
                
                
                IconView(vmIcon: icon, bWidth: 80, bHeight: 80)
                        .frame(alignment: .center)
                
                VStack {
                    Text(icon.tareaName)
                        .font(.footnote)
                }
                    
                   
                DatePicker("",
                           selection: $icon.startDate,
                           displayedComponents: [.date])
                
               
                Toggle("", isOn: $icon.status)
                    .toggleStyle(CheckToggleStyle())
                    
            }
        }
    }
}

#Preview {
    @Previewable @State var icon = IconModel(title: "Noisita titulo", tareaName: "Gatita preciosa bonita")
    IconRowView(icon: icon)
}
