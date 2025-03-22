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
                ForEach(StyleShape.allCases, id: \.self) { shape in
                    //Text("\(shape)").tag(shape)
                    ShapeView(shape: shape)
                        .onTapGesture {
                            //vmIcon.styleShape = shape
                        }
                    Spacer()
                }
            }
        } label: {
            Text("Shape").font(.headline)
        }
    }
}

struct ShapeView: View {
    var shape: StyleShape
    var body: some View {
        shape
            .fill(Color.blue)
            .foregroundStyle(Color.red)
            .frame(width: 20, height: 20)

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
