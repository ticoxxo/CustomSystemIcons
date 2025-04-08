//
//  ShapeSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 11/03/25.
//

import SwiftUI

struct ShapeSection: View {
    @Bindable var vmIcon: IconModel
    @State private var expanded: Bool = true
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            HStack {
                IconView(vmIcon: vmIcon, bWidth: 25, bHeight: 25, editable: false)
                    
                ForEach(StyleShape.allCases, id: \.self) { shape in
                    Spacer()
                    ShapeView(shape: shape, vmIcon: vmIcon)
                    Spacer()
                }
            }
            .customAccessibility(label: "lbl.Shape.Accessibility", hint: "Click on the shape to change the icon shape")
            .accessibilityAddTraits(.isButton)
        } label: {
            Text("Shape").font(.headline)
                .customAccessibility(label: "lbl.shape", hint: "Title for shape section")
                .accessibilityAddTraits(.isHeader)
        }
    }
}

struct ShapeView: View {
    var shape: StyleShape
    @Bindable var vmIcon: IconModel
    @State var animate: Bool = false
    var body: some View {
        shape
            .fill(Color.blue)
            .foregroundStyle(Color.red)
            .scaleEffect(animate ? 1 : 1.5)
            .transition(.scale)
            .frame(width: 20, height: 20)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.5)) {
                    animate.toggle()
                } completion: {
                    animate.toggle()
                }
                vmIcon.styleShape = shape
            }

    }
}

#Preview {
    @Previewable @State var vmIcon = IconModel()
    //vmIcon.icons.append(IconChild())
    //vmIcon.icons.append(IconChild())
    vmIcon.addIcon()
    vmIcon.addIcon()
    return ShapeSection(vmIcon: vmIcon)
}
