//
//  AddColor.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 17/01/25.
//

import SwiftUI
import SFSafeSymbols

//MARK: Maybe change view to use composition?

struct IconView: View {
    @State private var cachedImage: UIImage?
    var vmIcon: IconModel
    var editable: Bool
    @State private var containerSize: CGSize = .zero

    private var borderLineWidth: CGFloat {
        max(0, containerSize.width * vmIcon.borderWidth)
    }

    private var borderInset: CGFloat {
        borderLineWidth
    }

    var body: some View {
        ZStack {
            ForEach(vmIcon.icons) { icono in
                IconChildView(icono: icono, editable: editable)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .background {
                    GeometryReader { geo in
                        let size = geo.size
                        ZStack {
                            
                            if let img = cachedImage {
                                imageBackground(size: size, uiImage: img)
                            } else {
                                vmIcon.shape
                                    .fill(vmIcon.backgroundColor)
                            }
                        }
                        .onChange(of: size, initial: true) { _, newSize in
                            if containerSize != newSize {
                                containerSize = newSize
                            }
                        }
                    }
                    
                }
        .mask(vmIcon.shape.inset(by: borderInset))
        .overlay {
            if borderLineWidth > 0 {
                vmIcon.shape
                    .strokeBorder(vmIcon.borderColor, lineWidth: borderLineWidth)
            }
        }
        .onChange(of: vmIcon.backgroundImage.backgroundImage, initial: true) { _, data in
            let image = data.flatMap { ImageCache.shared.image(for: $0) }
            cachedImage = image
        }
        .shadow(
            color: vmIcon.shadows.shadowColor.opacity(vmIcon.shadows.opacity),
            radius: vmIcon.shadows.radius,
            x: vmIcon.shadows.shadowX,
            y: vmIcon.shadows.shadowY
        )
        
    }
    
    
    @ViewBuilder
    private func imageBackground(size: CGSize, uiImage: UIImage) ->  some View {
        
        Image(uiImage: uiImage)
        .resizable()                                    
            .scaledToFill()
            .scaleEffect(CGFloat(vmIcon.backgroundImage.zoom))
            .rotationEffect(.degrees(vmIcon.backgroundImage.orientation))
            .position(
                x: max(0, min(size.width, vmIcon.backgroundImage.positionX == 0 ? size.width / 2 : size.width * vmIcon.backgroundImage.positionX)),
                y: max(0, min(size.height, vmIcon.backgroundImage.positionY == 0 ? size.height / 2 : size.height * vmIcon.backgroundImage.positionY)
                      )
            )
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                        vmIcon.backgroundImage.positionX = value.location.x / size.width
                        vmIcon.backgroundImage.positionY = value.location.y / size.height
                        vmIcon.backgroundImage.dragging = true
                    }
                    .onEnded {_ in
                        vmIcon.backgroundImage.dragging = false
                    }
            )
            .simultaneousGesture(
                MagnifyGesture()
                    .onChanged { value in
                        vmIcon.backgroundImage.zoom = Float(value.magnification)
                    }
            )
    }
    
}



#Preview("Image background") {
    @Previewable @State var vmIcon = IconModel( )
    vmIcon.backgroundColor = Color.blue
    vmIcon.borderWidth = 0.05
    vmIcon.shape.cornerRadio = 0.4
    vmIcon.backgroundImage.backgroundImage = ImageDataLoader.loadPreviewImage()
    
    return VStack {
        IconView(vmIcon: vmIcon, editable: true)
        Spacer()
        Button {
            vmIcon.addText()
        } label: {
            Text("Add text")
        }
    }
    .frame(width: 400, height: 400)
}



#Preview("Text") {
    
    @Previewable @State var vmIcon = IconModel()
    vmIcon.addText()
    return IconView(vmIcon: vmIcon, editable: true)
        .frame(width: 200, height: 200)
        
}
