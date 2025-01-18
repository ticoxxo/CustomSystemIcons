//
//  AddColor.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 17/01/25.
//

import SwiftUI

struct AddColor: View {
    @Binding var color: Color
    var body: some View {
        HStack{
            Text("Background")
            ColorPicker("", selection: $color)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .labelsHidden()
    }
}

#Preview {
    @Previewable @State var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    AddColor(color: $bgColor)
}
