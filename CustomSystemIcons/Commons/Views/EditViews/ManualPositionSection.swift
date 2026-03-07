//
//  ManualPositionSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 25/04/25.
//

import SwiftUI

struct ManualPositionSection: View {
    @Bindable var vmIcon: IconModel
    @State private var expanded: Bool = true
    @ScaledMetric private var iconSize: CGFloat = 25
    @ScaledMetric private var textSize: CGFloat = 14
    
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            
            Grid(alignment: .leading) {
                GridRow {
                    Text("Icon")
                        .font(.subheadline)
                     title("-X")
                     title("+Y")
                     title("+X")
                     title("-Y")
                }
                ForEach($vmIcon.icons) { item in
                    GridRow {
                        Image(systemName: item.isIcon.wrappedValue ? item.name.wrappedValue : "textformat.alt")
                            .resizable()
                            .foregroundStyle(item.frontColor.wrappedValue)
                            .frame(width: iconSize, height: iconSize)
                        directionButton(
                            systemName: "arrowtriangle.left.circle.fill",
                            color: .pink
                        ) {
                            item.positionX.wrappedValue -= 0.01
                        }
                        directionButton(
                            systemName: "arrowtriangle.up.circle.fill",
                            color: MyColor.skyblue.value
                        ) {
                            item.positionY.wrappedValue -= 0.01
                        }
                        directionButton(
                            systemName: "arrowtriangle.right.circle.fill",
                            color: MyColor.skyblue.value
                        ) {
                            item.positionX.wrappedValue += 0.01
                        }
                        directionButton(
                            systemName: "arrowtriangle.down.circle.fill",
                            color: .pink
                        ) {
                            item.positionY.wrappedValue += 0.01
                        }
                    }
                }
            }
            
            
        } label: {
            Text("Label.ManualPosition").font(.headline)
                .customAccessibility(label: "Label.ManualPosition.Accessibility", hint: "Label.ManualPosition.Accessibility.Hint")
        }
        
    }
    
    @ViewBuilder
    private func title(_ title: String) -> some View {
        HStack {
          Spacer()
          Text(title)
              .font(.subheadline)
          Spacer()
      }
    }

    private func directionButton(
        systemName: String,
        color: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
                .foregroundStyle(color)
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
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
    return ManualPositionSection(vmIcon: vmIcon)
}

#Preview("Inside form") {
    @Previewable @State var vmIcon = IconModel()
    vmIcon.addIcon()
    vmIcon.addIcon()
    return Form {
        ManualPositionSection(vmIcon: vmIcon)
    }
}
