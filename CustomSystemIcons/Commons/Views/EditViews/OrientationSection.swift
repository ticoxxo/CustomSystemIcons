//
//  OrientationSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 06/03/25.
//

import SwiftUI
// TODO: Add background controls for orientation
struct OrientationSection: View {
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
                    Slider(
                        value: item.orientation,
                        in: 0.0...360.0
                    )
                    .customAccessibilityDouble(label: "Slider.Orientation.Accessibility", hint: "Slide to change orientation of icon", value: item.orientation)
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
                        value: $vmIcon.backgroundImage.orientation,
                        in: 0.0...360.0
                    )
                    .customAccessibilityDouble(label: "Slider.Background.Accessibility", hint: "Slide to change orientation of background", value: $vmIcon.backgroundImage.orientation)
                        
                }
                    
            }
            
        } label: {
            Text("Orientation").font(.headline)
                .customAccessibility(label: "Label orientation", hint: "Title for orientation section")
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
    return OrientationSection(vmIcon: vmIcon)
}
