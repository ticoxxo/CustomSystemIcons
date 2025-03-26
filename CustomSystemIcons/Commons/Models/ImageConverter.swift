//
//  ImageConverter.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 24/03/25.
//

import PhotosUI
import SwiftUI

@Observable
class ImageConverter: NSObject {
    var showAlert: Bool
    var alertMessage: String
    var savedImage: UIImage?
    
    init(showAlert: Bool = false,
         alertMessage: String = "Image saved successfully!",
         savedImage: UIImage? = nil) {
        self.showAlert = showAlert
        self.alertMessage = alertMessage
        self.savedImage = savedImage
    }
    
    
    
    @MainActor
    func convertViewAsImage(iconModel: IconModel) {
        let size = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 2
        let renderer = ImageRenderer(content: IconView(vmIcon: iconModel, bWidth: size ,bHeight: size, editable: false)
            .aspectRatio(1.0, contentMode: .fit)
        )
        
        if let uiImage = renderer.uiImage {
            UIImageWriteToSavedPhotosAlbum(uiImage, self, #selector(saveCompleted), nil)
            
        }
    }
    
    @MainActor
    func shareViewAsImage(iconModel: IconModel) -> UIImage? {
        let size = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 2
        let renderer = ImageRenderer(content: IconView(vmIcon: iconModel, bWidth: size ,bHeight: size, editable: false)
            .aspectRatio(1.0, contentMode: .fit)
        )
        
        
        return renderer.uiImage
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
                    print("Error saving image: \(error.localizedDescription)")
            self.alertMessage = "Error saving image: \(error.localizedDescription)"
                } else {
                    print("Image saved successfully!")
                    self.alertMessage = "Image saved successfully in your Photo Library!"
                }
        self.showAlert = true
        }
}

