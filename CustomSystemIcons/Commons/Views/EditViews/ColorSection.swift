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
    @Environment(\.imageCache) var imageCache
    @Bindable var vmIcon: IconModel
    @State private var expanded: Bool = true
    @State private var selectedPhoto: PhotosPickerItem?
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
                        HStack {
                            Text("\(Int(icon.zIndex.wrappedValue))")
                            Image(systemName: icon.isIcon.wrappedValue ? icon.name.wrappedValue : "textformat.alt")
                                .resizable()
                                .customAccessibility(label: "Button.Add.Accessibility", hint: "Button.Add.Hint", isButton: true)
                                .foregroundStyle(icon.frontColor.wrappedValue)
                                .frame(width: 25, height: 25)
                            
                            PickIcon(item: icon)
                            ColorPicker("ColorPicker.Icon", selection: icon.frontColor)
                                .customAccessibility(label: "ColorPicker.Icon.Accessibility", hint: "ColorPicker.Icon.Hint")
                            
                        }
                        .deleteDisabled(vmIcon.icons.count < 2)
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
            if let imageData =  vmIcon.backgroundImage.backgroundImage, let uiImage = imageCache.image(for: imageData) {
                
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

