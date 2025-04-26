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
    
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            ForEach($vmIcon.icons) { item in
                HStack {
                    Image(systemName: item.name.wrappedValue)
                        .resizable()
                        .foregroundStyle(item.frontColor.wrappedValue)
                        .frame(width: 25, height: 25)
                    Divider()
                    Spacer()
                    ManualPositionPad(vmIcon: item)
                    Spacer()
                }
            }
            
        } label: {
            Text("Label.ManualPosition").font(.headline)
                .customAccessibility(label: "Label.ManualPosition.Accessibility", hint: "Label.ManualPosition.Accessibility.Hint")
        }
        
    }
}

struct ManualPositionPad: View {
    @Binding var vmIcon: IconChild

    var body: some View {
        Image(systemName: "arrowtriangle.left.circle.fill")
            .resizable()
            .customAccessibility(label: "Label.ManualPosition.Left.Accessibility", hint: "Label.ManualPosition.Left.Accessibility.Hint", isButton: true)
            .accessibilityAction(named: Text("Drag.Left")) {
                vmIcon.positionX += 0.01
            }
            .foregroundStyle(MyColor.skyblue.value)
            .aspectRatio(contentMode: .fit)
            .frame(width: min(horizontalPadding / 20, verticalPadding / 20),
                   height: min(horizontalPadding / 20, verticalPadding / 20))
            .onTapGesture {
                vmIcon.positionX -= 0.01
            }
        Spacer()
        Image(systemName: "arrowtriangle.up.circle.fill")
            .resizable()
            .customAccessibility(label: "Label.ManualPosition.Up.Accessibility", hint: "Label.ManualPosition.Up.Accessibility.Hint", isButton: true)
            .accessibilityAction(named: Text("Drag.Up")) {
                vmIcon.positionX -= 0.01
            }
            .foregroundStyle(MyColor.skyblue.value)
            .aspectRatio(contentMode: .fit)
            .frame(width: min(horizontalPadding / 20, verticalPadding / 20),
                   height: min(horizontalPadding / 20, verticalPadding / 20))
            .onTapGesture {
                vmIcon.positionY -= 0.01
            }
        Spacer()
        Image(systemName: "arrowtriangle.right.circle.fill")
            .resizable()
            .customAccessibility(label: "Label.ManualPosition.Right.Accessibility", hint: "Label.ManualPosition.Right.Accessibility.Hint", isButton: true)
            .accessibilityAction(named: Text("Drag.Right")) {
                vmIcon.positionX += 0.01
            }
            .foregroundStyle(MyColor.skyblue.value)
            .aspectRatio(contentMode: .fit)
            .frame(width: min(horizontalPadding / 20, verticalPadding / 20),
                   height: min(horizontalPadding / 20, verticalPadding / 20))
            .onTapGesture {
                vmIcon.positionX += 0.01
            }
        Spacer()
        Image(systemName: "arrowtriangle.down.circle.fill")
            .resizable()
            .customAccessibility(label: "Label.ManualPosition.Down.Accessibility", hint: "Label.ManualPosition.Down.Accessibility.Hint", isButton: true)
            .accessibilityAction(named: Text("Drag.Down")) {
                vmIcon.positionY += 0.01
            }
            .foregroundStyle(MyColor.skyblue.value)
            .aspectRatio(contentMode: .fit)
            .frame(width: min(horizontalPadding / 20, verticalPadding / 20),
                   height: min(horizontalPadding / 20, verticalPadding / 20))
            .onTapGesture {
                vmIcon.positionY += 0.01
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
    return ManualPositionSection(vmIcon: vmIcon)
}
