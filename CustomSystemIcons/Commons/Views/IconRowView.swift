//
//  IconRowView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 22/01/25.
//

import SwiftUI

struct IconRowView: View {
    @Binding var icon: IconModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(icon.title)")
                .font(.largeTitle)
            HStack {
                IconView(vmIcon: icon)
                    .frame(width: 50, height: 50)
                Text(icon.description)
                    .font(.footnote)
                    
                   
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
    @Previewable @State var icon = IconModel(title: "Noisita titulo", description: "Gatita preciosa bonita")
    IconRowView(icon: $icon)
}
