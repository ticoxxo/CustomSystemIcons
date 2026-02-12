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
            Grid(alignment: .leading) {
                GridRow {
                    Text("Select figure")
                    Spacer()
                    Picker("Select figure", selection: $vmIcon.shape.selectedPath) {
                        Text("Circle").tag(FiguraSelected.circle)
                        Text("Rectangle").tag(FiguraSelected.rectangle)
                        Text("Star").tag(FiguraSelected.star)
                        Text("Custom").tag(FiguraSelected.custom)
                    }
                    .labelsHidden()
                }
                
                GridRow {
                    Text("Add corners")
                    Spacer()
                    Picker("Select corners", selection: $vmIcon.shape.corners) {
                        ForEach(3..<20) { number in
                            Text("\(number) corners").tag(number)
                        }
                    }
                    .labelsHidden()
                }
                
                
            }
        } label: {
            Text("Label.Shape").font(.headline)
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
            .fill(MyColor.skyblue.value)
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
    vmIcon.borderWidth = 0.05
    vmIcon.addIcon()
    vmIcon.addIcon()
    return VStack {
        Text("Corners = \(vmIcon.shape.corners)")
        IconView(vmIcon: vmIcon,
                 editable: true)
        .frame(width: 200, height: 200)
        ShapeSection(vmIcon: vmIcon)
    }
}
