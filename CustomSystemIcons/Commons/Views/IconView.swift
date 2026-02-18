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
    @Environment(\.imageCache) var imageCache
    var vmIcon: IconModel
    var editable: Bool
    
    var body: some View {
        ZStack {
            ForEach(vmIcon.icons) { icono in
                IconChildView(icono: icono, editable: editable)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .clipShape(vmIcon.shape)
        .background {
                    GeometryReader { geo in
                        if let data = vmIcon.backgroundImage.backgroundImage, let uiImage = imageCache.image(for: data) {
                            imageBackground(size: geo.size, uiImage: uiImage)
                                .clipShape(vmIcon.shape)
                        } else {
                            vmIcon.shape
                                .fill(vmIcon.backgroundColor)
                        }
                        ZStack {
                            vmIcon
                                .shape
                                .strokeBorder(vmIcon.borderColor, lineWidth: geo.size.width * vmIcon.borderWidth)
                        }
                    }
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

/*
 .overlay {
     GeometryReader { geo in
         vmIcon.styleShape.withRadio(vmIcon.cornerRadio)
             
     }
     
 }
 */

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

/*
 struct IconView: View {
     var vmIcon: IconModel
     var editable: Bool
     
     var body: some View {
         ZStack {
             ForEach(vmIcon.icons) { icono in
                 IconChildView(icono: icono, editable: editable)
             }
         }
         .background {
             if vmIcon.backgroundImage.backgroundImage != nil {
                 BackgroundView(background: vmIcon.backgroundImage)
             } else {
                 vmIcon.backgroundColor
             }
         }
         .clipShape(vmIcon.styleShape.withRadio(vmIcon.cornerRadio))
         .overlay(
             GeometryReader { geo in
                 vmIcon.styleShape.withRadio(vmIcon.cornerRadio)
                     .strokeBorder(
                         vmIcon.borderColor,
                         lineWidth: geo.size.width * vmIcon.borderWidth
                     )
             }
         )
         .shadow(
             color: vmIcon.shadows.shadowColor.opacity(vmIcon.shadows.opacity),
             radius: vmIcon.shadows.radius,
             x: vmIcon.shadows.shadowX,
             y: vmIcon.shadows.shadowY
         )
         .frame(maxWidth: .infinity, maxHeight: .infinity)
         .aspectRatio(1, contentMode: .fit)
     }
 }


 #Preview {
     //@Previewable @State var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
     //@Previewable @State var vmIcon = IconModel(styleShape: .square(radio: 5), borderWidth: 0.05)
     //@Previewable @State var vmIcon = IconModel(styleShape: .circle, borderWidth: 0.01)
     //@Previewable @State var vmIcon = IconModel(styleShape: .star(radio: 5), borderWidth: 0.05)
     //@Previewable @State var vmIcon = IconModel(styleShape: .triangle(radio: 30), borderWidth: 0.05)
     //@Previewable @State var vmIcon = IconModel(styleShape: .square(radio: 30), borderWidth: 0.05)
     @Previewable @State var vmIcon = IconModel( )
     vmIcon.backgroundColor = Color.blue
     vmIcon.borderWidth = 0.06
     vmIcon.styleShape = .hexagon(radio: 0.0)
     return ZStack {
         
         Rectangle()
             .fill(.red)
             .frame(maxWidth: .infinity, maxHeight: .infinity)
         IconView(vmIcon: vmIcon, editable: true)
     }
     .foregroundColor(Color.black)
     .background(Color.primary
                             .colorInvert()
                             .opacity(0.75))
     .frame(width: 400, height: 400)
         
 }

 #Preview("Text") {
     
     @Previewable @State var vmIcon = IconModel(icons: [IconChild(
         name: "Hola, mundo",
         isIcon: false,
         textProperties: TextModel.dataPreviewExample)] )
     vmIcon.backgroundColor = Color.blue
     vmIcon.borderWidth = 0.09
     vmIcon.styleShape = .hexagon(radio: 0.0)
     return ZStack {
         
         Rectangle()
             .fill(.red)
             .frame(maxWidth: .infinity, maxHeight: .infinity)
         IconView(vmIcon: vmIcon, editable: true)
     }
     .foregroundColor(Color.black)
     .background(Color.primary
                             .colorInvert()
                             .opacity(0.75))
     .frame(width: 200, height: 200)
         
 }
 
 
 
 // MARK: This one
 
 #Preview {
     //@Previewable @State var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
     //@Previewable @State var vmIcon = IconModel(styleShape: .square(radio: 5), borderWidth: 0.05)
     //@Previewable @State var vmIcon = IconModel(styleShape: .circle, borderWidth: 0.01)
     //@Previewable @State var vmIcon = IconModel(styleShape: .star(radio: 5), borderWidth: 0.05)
     //@Previewable @State var vmIcon = IconModel(styleShape: .triangle(radio: 30), borderWidth: 0.05)
     //@Previewable @State var vmIcon = IconModel(styleShape: .square(radio: 30), borderWidth: 0.05)
     @Previewable @State var vmIcon = IconModel( )
     vmIcon.backgroundImage.backgroundImage = ImageDataLoader.loadPreviewImage()
     vmIcon.shape.corners = 12
     vmIcon.shape.selectedPath = .custom
     vmIcon.backgroundColor = Color.blue
     vmIcon.borderWidth = 0.05
     vmIcon.shape.cornerRadio = 0.4
     let iconView = IconView(vmIcon: vmIcon, editable: false)
     let render = ImageRenderer(content: iconView)
     
     render.proposedSize = ProposedViewSize(
         width: CGFloat(500),
         height: CGFloat(500)
     )
     return Image(uiImage: render.uiImage!)
 }
 
 // MARK: IN CASE OF CHANGES
 
 .background {
     GeometryReader { geo in
         vmIcon.shape
             .fill(vmIcon.backgroundColor)
             .strokeBorder(vmIcon.borderColor, lineWidth: geo.size.width * vmIcon.borderWidth)
     }
 }

 */
