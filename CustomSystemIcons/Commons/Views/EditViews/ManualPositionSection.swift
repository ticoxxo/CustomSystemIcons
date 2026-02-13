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
                        .font(.title)
                     title("-X")
                     title("+Y")
                     title("+X")
                     title("-Y")
                }
                ForEach($vmIcon.icons) { item in
                    GridRow {
                        Image(systemName: item.name.wrappedValue)
                            .resizable()
                            .foregroundStyle(item.frontColor.wrappedValue)
                            .frame(width: iconSize, height: iconSize)
                        PositionPad(vmIcon: item, iconSize: iconSize)
                            .padding()
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
              .font(.title)
          Spacer()
      }
    }
    
    
    private struct PositionPad:  View {
        @Binding var vmIcon: IconChild
        var iconSize: CGFloat
        var body: some View {
            
                Button {
                    vmIcon.positionX -= 0.01
                } label: {
                    Image(systemName: "arrowtriangle.left.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //.frame(width: iconSize, height: iconSize)
                        .foregroundStyle(Color.pink)
                }
                
                Button {
                    vmIcon.positionY += 0.01
                } label: {
                    Image(systemName: "arrowtriangle.up.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //.frame(width: iconSize, height: iconSize)
                        .foregroundStyle(MyColor.skyblue.value)
                }
                
                Button {
                    vmIcon.positionX += 0.01
                } label: {
                    Image(systemName: "arrowtriangle.right.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //.frame(width: iconSize, height: iconSize)
                        .foregroundStyle(MyColor.skyblue.value)
                }
                
                Button {
                    vmIcon.positionY -= 0.01
                } label: {
                    Image(systemName: "arrowtriangle.down.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //.frame(width: iconSize, height: iconSize)
                        .foregroundStyle(Color.pink)
                }
                
            
            
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

#Preview("Inside form") {
    @Previewable @State var vmIcon = IconModel()
    vmIcon.addIcon()
    vmIcon.addIcon()
    return Form {
        ManualPositionSection(vmIcon: vmIcon)
    }
}
