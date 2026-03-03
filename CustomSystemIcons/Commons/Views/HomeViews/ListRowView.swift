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
    @Environment(\.colorScheme) var colorScheme
    @State private var messageAlert = ""
    @State private var showAlert = false
    @ScaledMetric private var spacing = 10.0
    @ScaledMetric private var iconSize = 15.0
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [colorSpri,.white]), startPoint: UnitPoint(x: 0.1, y: 0.2), endPoint: UnitPoint(x: 0.2, y: 0.1))
                    .opacity(0.7)
                IconCardLayout {
                    HStack {
                        Spacer()
                        starButton
                    }
                    IconView(vmIcon: item, editable: false)
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(.red, lineWidth: 3)
                        .overlay(
                            Text(item.title)
                                .foregroundStyle(.white)
                                .font(.title2)
                                .minimumScaleFactor(0.3)
                                .lineLimit(1)
                                .padding(.horizontal, 4)
                        )
                }
                .padding()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 15.0))
    }
    
    @ViewBuilder
    var starButton: some View {
        Button {
            item.isFavorite.toggle()
            do {
                try modelContext.save()
            } catch {
                messageAlert = "Label.Error.Save"
                showAlert = true
            }
        } label: {
            Image(systemName: item.isFavorite ? "star.fill" : "star")
                .resizable()
                .scaledToFit()
                .foregroundColor(item.isFavorite ? .yellow : .blue)
        }
    }
    
    private var colorSpri: Color {
        item.backgroundColorComputed.color == .white ? MyColor.skyblue.value : item.backgroundColor
    }
}

struct IconCardLayout: Layout {
    func sizeThatFits(
            proposal: ProposedViewSize,
            subviews: Subviews,
            cache: inout Void
        ) -> CGSize {
            guard !subviews.isEmpty else { return .zero }
            
            // Accept the full proposed size from parent
            return CGSize(
                width: proposal.width ?? 0,
                height: proposal.height ?? 0
            )
        }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) {
        guard !subviews.isEmpty else { return }
        
        let width = bounds.width
        let height = bounds.height
        let firstHeight = height * 1.0 / 8.0
        let secondHeight = height * 5.0 / 8.0
        let interSectionSpacing = min(8.0, height * 0.03)
        let thirdHeight = max(0.0, height - firstHeight - secondHeight - interSectionSpacing)
        
        // First: 1/8 height (top)
        subviews[0].place(
            at: CGPoint(x: bounds.midX, y: bounds.minY + firstHeight / 2.0),
            anchor: .center,
            proposal: ProposedViewSize(width: width, height: firstHeight)
        )
        
        // Second: 5/8 height (middle)
        if subviews.count > 1 {
            subviews[1].place(
                at: CGPoint(x: bounds.midX, y: bounds.minY + firstHeight + secondHeight / 2.0),
                anchor: .center,
                proposal: ProposedViewSize(width: width, height: secondHeight)
            )
        }
        
        // Third: remaining height (bottom), with a small gap from the second
        if subviews.count > 2 {
            subviews[2].place(
                at: CGPoint(x: bounds.midX, y: bounds.minY + firstHeight + secondHeight + interSectionSpacing + thirdHeight / 2.0),
                anchor: .center,
                proposal: ProposedViewSize(width: width, height: thirdHeight)
            )
        }
    }
    
    
}

/*
 .background(
     //LinearGradient(gradient: Gradient(colors: [item.backgroundColor,.white]), startPoint: UnitPoint(x: 0.2, y: 0.2), endPoint: UnitPoint(x: 0.2, y: 0.2))
     LinearGradient(gradient: Gradient(colors: [item.backgroundColor,.white]), startPoint: UnitPoint(x: 0.1, y: 0.2), endPoint: UnitPoint(x: 0.2, y: 0.1))
 )
 .glow(color: .gray, radius: 15)
 .cornerRadius(10)
 */

#Preview {
    
    @Previewable @State var item = ModelsExample.singleIconModelExample()
    VStack {
        ListRowView(item: item)
            .frame(width: 350, height: 400)
            
    }
   
}
