//
//  PositionSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 27/02/25.
//

import SwiftUI

struct PositionSection: View {
    @Bindable var vmIcon: IconModel
    @State private var expanded: Bool = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            ForEach($vmIcon.icons) { item in
                HStack {
                    Image(systemName: item.name.wrappedValue)
                        .resizable()
                        .foregroundStyle(item.frontColor.wrappedValue)
                        .frame(width: 25, height: 25)
                    Slider(value: item.zoom, in:0.2...1.0)
                }
                
            }
        } label: {
            Text("Manual zoom").font(.headline)
        }
    }
}


#Preview {
    @Previewable @State var vmIcon = IconModel()
    //vmIcon.icons.append(IconChild())
    //vmIcon.icons.append(IconChild())
    vmIcon.addIcon()
    vmIcon.addIcon()
    return PositionSection(vmIcon: vmIcon)
}

/*
VStack {
    ZStack {
        ForEach(vmIcon.icons) { icon in
            Image(systemName: icon.name)
                .resizable()
                .frame(width: 200, height: 200)
                .offset(x: CGFloat.random(in: 1...100))
                .foregroundStyle(icon.frontColor)
                .zIndex(icon.zIndex)
        }
    }
    
    Section(header: Text("Position").font(.headline)) {
        VStack {
            HStack {
                ForEach(vmIcon.icons) { iconote in
                    Text("\(iconote.zIndex)")
                }
            }
            
            HStack {
                Text("Layer")
                ForEach(vmIcon.icons) { iconito in
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Image(systemName: iconito.name)
                                .resizable()
                                .foregroundStyle(iconito.frontColor)
                                .frame(width: 20, height: 20)
                                .offset(x: iconito.offset.width , y: iconito.offset.height)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            iconito.offset = gesture.translation
                                            
                                        }
                                        .onEnded { _ in
                                            
                                            iconito.offset = .zero
                                            
                                        }
                                )
                                .animation(.easeInOut, value: iconito.offset)
                                .frame(width: 40, height: 40)
                        }
                }
            }
            
            
            
        }
    }
    
} */
