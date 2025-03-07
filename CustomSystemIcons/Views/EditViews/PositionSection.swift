//
//  PositionSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 27/02/25.
//

import SwiftUI

struct PositionSection: View {
    @Bindable var vmIcon: IconModel
    var off: CGFloat = 0
    @State private var offset = CGSize.zero
    let sports = ["figure.badminton", "figure.cricket", "figure.fencing"]
    @State private var dropImage = Image(systemName: "photo")
    
    var body: some View {
        
        Section(header: Text("List Section").font(.headline)) {
            List {
                ForEach(vmIcon.icons) { item in
                    
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 200, height: 50)
                        .overlay {
                            HStack {
                                Text("\(item.zIndex)")
                                ImageDraggable(item: item)
                            }
                        }
                        
                }
                .onMove(perform: vmIcon.moveRow)
            }
        }
       
    }
    
   
}

struct ImageDraggable: View {
    let item: IconChild
    var body: some View {
        Image(systemName: item.name)
            .resizable()
            .foregroundStyle(item.frontColor)
            .frame(width: 25, height: 25)
            .draggable(Image(systemName: item.name)) {
                Image(systemName: item.name)
                    .resizable()
                    .foregroundStyle(item.frontColor)
                    .frame(width: 20, height: 20)
            }
    }
}

struct ImagePosition: View {
    
    @State private var dropImage = Image(systemName: "photo")

    var body: some View {
        
        VStack {
            dropImage
                .resizable()
                .zIndex(1)
                .background(.green)
                .foregroundStyle(.white)
                .dropDestination(for: Image.self) { items, location in
                    dropImage =  Image(systemName: "star.fill")
                    return true
                }
                
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
