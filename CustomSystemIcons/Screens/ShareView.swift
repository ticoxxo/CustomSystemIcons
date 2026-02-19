//
//  ShareView.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 18/02/26.
//

import SwiftUI

struct ShareView: View {
    @State private var animateIcon = false
    
    @State private var model: ImageConverter = ImageConverter()
    
    var vmIcon: IconModel
    
    var imgSize: [ImageSize] {
        ImageSize.availableSizes(for: model.imageType)
    }
    
    var body: some View {
        Form {
            
            Section(header: Text("Picker.ImageType")) {
                
                    Picker("Picker.ImageType", selection: $model.imageType) {
                        ForEach(ImageType.allCases) { imgType in
                            Text(imgType.displayName).tag(imgType)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    

            }
            
            Section(header: Text("Picker.ImageSize")) {
                Picker("Select image size", selection: $model.imageSize) {
                    ForEach(imgSize) { size in
                        Text(size.displayName).tag(size)
                    }
                }
                .pickerStyle(.automatic)
            }
            
            Section(header: Text("Label.ShareView.Compression")) {
                if model.imageType == .jpeg {
                        VStack(alignment: .leading) {
                            Text("Compression Quality: \(Int(model.compressionQuality * 100))%")
                            Slider(value: $model.compressionQuality, in: 0.1...1.0, step: 0.05)
                        }
                    } else {
                        Text("Lossless")
                            .foregroundStyle(.secondary)
                    }
            }
            
            Section(header: Text("Label.ShareView.Transparency")) {
                if model.imageType == .jpeg {
                    Text("JPEG does not support transparency")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                } else {
                    Toggle("Remove Background", isOn: $model.removeBackground)
                    Text("Export with transparent background (alpha channel)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            
        }
        .offset(x: animateIcon ? 0 : -horizontalPadding)
        .transition(.scale)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                animateIcon = true
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                GoBackButton()
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(item: model.processViewToUrl(iconModel: vmIcon)) {
                    Label("Share as \(model.imageType.displayName)", systemImage: "square.and.arrow.up")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    
    @Previewable @State var vmIcon = IconModel()
    vmIcon.backgroundColor = Color.blue
    vmIcon.borderWidth = 0.05
    vmIcon.shape.cornerRadio = 0.4
    vmIcon.backgroundImage.backgroundImage = ImageDataLoader.loadPreviewImage()
    return NavigationStack {
        ShareView(vmIcon: vmIcon)
    }
}
