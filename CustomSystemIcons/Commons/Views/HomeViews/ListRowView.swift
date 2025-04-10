//
//  ListRowView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 01/04/25.
//

import SwiftUI

struct ListRowView: View {
    var item: IconModel
    @Environment(\.modelContext) var modelContext
    @State private var messageAlert = ""
    @State private var showAlert = false
    var body: some View {
        GeometryReader { geometry in
            VStack {
                IconView(vmIcon: item, bWidth: min(geometry.size.width / 2, geometry.size.height / 2), bHeight: min(geometry.size.width / 2, geometry.size.height / 2),editable: false)
                ZStack {
                    Rectangle()
                        .strokeBorder(
                            LinearGradient(gradient: Gradient(colors: [.black,.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            , lineWidth: 2)
                        .background(.white)
                        .cornerRadius(2)
                        .padding()
                    Text("\(item.title)")
                        .customAccessibility(label: "Label title", hint: "Text for icon")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .lineLimit(1) // Restrict to one line
                                .truncationMode(.tail)
                                .padding()// Truncate with ellipsis if needed
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .overlay(alignment: .topTrailing) {
            StarView(item: item)
                .onTapGesture {
                    item.isFavorite.toggle()
                    do {
                        try modelContext.save()
                    } catch {
                        messageAlert = "Error updating favorite"
                        showAlert = true
                    }
                }
        }
        .background(
            //LinearGradient(gradient: Gradient(colors: [item.backgroundColor,.white]), startPoint: UnitPoint(x: 0.2, y: 0.2), endPoint: UnitPoint(x: 0.2, y: 0.2))
            LinearGradient(gradient: Gradient(colors: [item.backgroundColor,.white]), startPoint: UnitPoint(x: 0.1, y: 0.2), endPoint: UnitPoint(x: 0.2, y: 0.1))
            )
        .glow(color: .gray, radius: 15)
        .cornerRadius(10)
        .frame(width:min(horizontalPadding / 3, verticalPadding / 3),
        height: min(horizontalPadding / 2, verticalPadding / 2))
    }
}

#Preview {
    @Previewable @State var item = IconModel(title: "Titulo asdads asdsad")
    
    ListRowView(item: item)
}
