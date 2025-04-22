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
                        .customAccessibilityFloat(label: "Slider.Zoom.Accessibility", hint: "Slider.Zoom.Accessibility.Hint", value: item.zoom)
                }
                
            }
            
            if let imageData =  vmIcon.backgroundImage.backgroundImage, let uiImage = UIImage(data: imageData) {
                //Image(uiImage: UIImage(data: imageData)!)
                HStack {
                        
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: min(horizontalPadding / 10, verticalPadding / 10),
                               height: min(horizontalPadding / 10, verticalPadding / 10))
                    Slider(
                        value: $vmIcon.backgroundImage.zoom,
                        in:0.0...10.0
                    )
                    .customAccessibilityFloat(label: "Slider.Background.Zoom.Accessibility", hint: "Slider.Background.Zoom.Accessibility.Hint", value: $vmIcon.backgroundImage.zoom)
                        
                }
                    
            }
            
        } label: {
            Text("Label.Zoom").font(.headline)
                .customAccessibility(label: "Label.Zoom.Accessibility", hint: "Title for zoom manual section")
        }
    }
}


#Preview {
    @Previewable @State var vmIcon = IconModel()
    let sampleImage = UIImage(systemName: "star.fill")?.pngData()
    // Replace with your image name
    let backgroundModel = BackgroundImageModel(
        backgroundImage: sampleImage,
        positionX: 0.5,
        positionY: 0.5
    )
    vmIcon.backgroundImage = backgroundModel
    //vmIcon.icons.append(IconChild())
    //vmIcon.icons.append(IconChild())
    vmIcon.addIcon()
    vmIcon.addIcon()
    return PositionSection(vmIcon: vmIcon)
}
