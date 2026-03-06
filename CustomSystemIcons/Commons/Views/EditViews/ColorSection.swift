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
    @State private var cachedImage: UIImage?
    @Bindable var vmIcon: IconModel
    @State private var expanded: Bool = true
    @State private var selectedPhoto: PhotosPickerItem?
    @ScaledMetric private var iconSize = 25.0
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            
            Grid {
                GridRow {
                    ColorPicker("ColorPicker.Background", selection: $vmIcon.backgroundColor)
                }
                
                GridRow {
                    photoPickerView
                }
            }
            
            Section(header: Text("Label.ColorSection.ActionsList")) {
                List {
                    ForEach($vmIcon.iconsSorted) { icon in
                        iconRow(icon)
                            .deleteDisabled(vmIcon.icons.count < 2)
                            .moveDisabled(vmIcon.icons.count < 2)
                    }
                    .onMove(perform: vmIcon.moveRow)
                    .onDelete(perform: vmIcon.removeIcon)
                }
            }
            
        } label: {
            Text("lbl.layers")
                .customAccessibility(label: "lbl.layers", hint: "lbl.layers.hint")
                .font(.headline)
        }
        .onChange(of: vmIcon.backgroundImage.backgroundImage, initial: true) { _, data in
            let image = data.flatMap { ImageCache.shared.image(for: $0) }
            vmIcon.backgroundImage.cachedUIImage = image
        }
    }
    
    @ViewBuilder
    private func iconRow(_ icon: Binding<IconChild>) -> some View {
        let row = HStack {
            Text("\(Int(icon.zIndex.wrappedValue))")
            Image(systemName: icon.isIcon.wrappedValue ? icon.name.wrappedValue : "textformat.alt")
                .resizable()
                .scaledToFit()
                .foregroundStyle(icon.frontColor.wrappedValue)
                .frame(width: iconSize, height: iconSize)
            
            PickIcon(item: icon)
            HStack {
                Spacer()
                CustomColorPicker(color: icon.frontColor)
            }
        }
        
        row
    }
    
    @ViewBuilder
    private var photoPickerView: some View {
        HStack {
            PhotosPicker(
                selection: $selectedPhoto,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Text("Label.PhotosPicker")
                    
            }
            .onChange(of: selectedPhoto) {
                Task {
                    await vmIcon.loadImageData(from: selectedPhoto)
                }
            }
            .photosPickerStyle(.presentation)
            
            Spacer()
            if let image =  vmIcon.backgroundImage.cachedUIImage {
                
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
                    Image(uiImage: image)
                        .resizable()
                        .foregroundStyle(MyColor.skyblue.value)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: min(horizontalPadding / 10, verticalPadding / 10),
                               height: min(horizontalPadding / 10, verticalPadding / 10))
                        
                }
                    
            } else {

                Image(systemName: "photo.badge.plus.fill")
                    .resizable()
                    .foregroundStyle(MyColor.skyblue.value)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: min(horizontalPadding / 10, verticalPadding / 10),
                           height: min(horizontalPadding / 10, verticalPadding / 10))
                    
            }
        }
        
    }
}


#Preview {
    @Previewable @State var vmIcon = IconModel()
    vmIcon.addIcon()
    vmIcon.addText()
    return Form {
        ColorSection(vmIcon: vmIcon)
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

