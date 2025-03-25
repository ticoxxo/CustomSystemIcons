//
//  ImageConverter.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 24/03/25.
//

import PhotosUI
import SwiftUI


class ImageConverter: NSObject {
    @MainActor
    func downloadViewAsImage(iconModel: IconModel) {
        let size = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 2
        let renderer = ImageRenderer(content: IconView(vmIcon: iconModel, bWidth: size ,bHeight: size, editable: false)
            .aspectRatio(1.0, contentMode: .fit)
        )
        
        if let uiImage = renderer.uiImage {
            UIImageWriteToSavedPhotosAlbum(uiImage, self, #selector(saveCompleted), nil)
        }
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
                    print("Error saving image: \(error.localizedDescription)")
                } else {
                    print("Image saved successfully!")
                }
        }
}

