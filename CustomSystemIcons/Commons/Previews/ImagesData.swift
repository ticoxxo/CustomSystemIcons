//
//  ImagesData.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 10/02/26.
//
import SwiftUI

struct ImageDataLoader {
    static func loadImageData(named imageName: String) -> Data? {
           
            guard let image = UIImage(named: imageName) else {
                print("❌ Could not find image named: \(imageName)")
                return nil
            }
            
           
            return image.pngData()
        }
        
        // Convenience method with default image
        static func loadPreviewImage() -> Data? {
            loadImageData(named: "previewclown")
        }
}
