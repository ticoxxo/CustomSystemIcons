//
//  ColorSection.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 27/02/25.
//

import SwiftUI
import PhotosUI

struct ColorSection: View {
    @Environment(\.coordinator) var coordinator
    @Bindable var vmIcon: IconModel
    @State private var expanded: Bool = true
    @State private var selectedPhoto: PhotosPickerItem?
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            
            HStack {
                ColorPicker("Background color", selection: $vmIcon.backgroundColor)
                    .customAccessibility(label: "Background color picker", hint: "Pick a color for the background")
                    
            }
            HStack {
                PhotosPicker(
                    selection: $selectedPhoto,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Text("Lbl.PhotosPicker")
                        .customAccessibility(label: "Lbl.PhotosPicker.Accessibility", hint: "Press to pick a photo from the library")
                }
                .onChange(of: selectedPhoto) {
                    Task {
                        await vmIcon.loadImageData(from: selectedPhoto)
                    }
                }
                .photosPickerStyle(.presentation)
                
                Spacer()
                if let imageData =  vmIcon.backgroundImage.backgroundImage, let uiImage = UIImage(data: imageData) {
                    //Image(uiImage: UIImage(data: imageData)!)
                    HStack {
                            
                        Image(systemName: "x.circle")
                            .resizable()
                            .foregroundStyle(Color.red)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: min(horizontalPadding / 20, verticalPadding / 20),
                                   height: min(horizontalPadding / 20, verticalPadding / 20))
                            .onTapGesture {
                                vmIcon.backgroundImage.backgroundImage = nil
                            }
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: min(horizontalPadding / 10, verticalPadding / 10),
                                   height: min(horizontalPadding / 10, verticalPadding / 10))
                            
                    }
                    .customAccessibility(label: "Lbl.BackgroundImage.Accessibility", hint: "Lbl.BackgroundImage.Accessibility.Hint")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityAction {
                        vmIcon.backgroundImage.backgroundImage = nil
                    }
                        
                } else {

                    Image(systemName: "photo.badge.plus.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: min(horizontalPadding / 10, verticalPadding / 10),
                               height: min(horizontalPadding / 10, verticalPadding / 10))
                        
                }
            }
            
            List {
                ForEach($vmIcon.icons.sorted { $0.zIndex.wrappedValue < $1.zIndex.wrappedValue }) { icon in
                    HStack {
                        Text("\(Int(icon.zIndex.wrappedValue))")
                        Image(systemName: "\(icon.name.wrappedValue)")
                            .resizable()
                            .customAccessibility(label: "Icon button", hint: "Press to select the a new icon", isButton: true)
                            .foregroundStyle(icon.frontColor.wrappedValue)
                            .frame(width: 25, height: 25)
                        
                        PickIcon(item: icon)
                        ColorPicker("Pick a color for the icon", selection: icon.frontColor)
                            .customAccessibility(label: "Background color picker", hint: "Pick a color for the icon")
                        
                    }
                    .deleteDisabled(vmIcon.icons.count < 2)
                }
                .onMove(perform: vmIcon.moveRow)
                .onDelete(perform: vmIcon.removeIcon)
            }
            
        } label: {
            Text("Background and layers")
                .customAccessibility(label: "lbl.layers", hint: "Title for background and layers section")
                .font(.headline)
        }
    }
}

/*

#Preview {
    @Previewable @State var vmIcon = IconModel()
    vmIcon.icons.append(IconChild())
    vmIcon.icons.append(IconChild())
    vmIcon.icons[1].zIndex = 2.0
    vmIcon.icons[2].zIndex = 3.0
    return ColorSection(vmIcon: vmIcon)
}

*/
