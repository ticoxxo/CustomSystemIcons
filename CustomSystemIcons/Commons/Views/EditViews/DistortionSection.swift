//
//  DistortionSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 22/04/25.
//

import SwiftUI

struct DistortionSection: View {
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
                    VStack {
                        Slider(value: item.xDistortion, in:-1.0...1.0)
                            .customAccessibilityCGFloat(label: "Slider.Background.DistortionX.Accessibility", hint: "Slider.Background.DistortionX.Accessibility.Hint", value: item.xDistortion)
                            .tint(item.frontColor.wrappedValue)
                            
                        Slider(value: item.yDistortion, in:-1.0...1.0)
                            .customAccessibilityCGFloat(label: "Slider.Background.DistortionY.Accessibility", hint: "Slider.Background.DistortionY.Accessibility.Hint", value: item.yDistortion)
                            .tint(item.frontColor.wrappedValue)
                            
                    }
                }
                
            }
        } label: {
            Text("Label.Distortion").font(.headline)
                .customAccessibility(label: "Label.Distortion.Accessibility", hint: "Label.Distortion.Accessibility.Hint")
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
    return DistortionSection(vmIcon: vmIcon)
}
