//
//  DateView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 23/01/25.
//

import SwiftUI

struct DateView: View {
    @Binding var date: Date
    let title: String?
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    @Previewable @State var date = Date.now
    let title = "Cumpleaños"
    DateView(date: $date, title: title)
}


