//
//  ImageConverter.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 24/03/25.
//

import PhotosUI
import SwiftUI



@Observable
class ImageConverter {
    var showAlert: Bool
    var alertMessage: String
    var savedImage: UIImage?
    
    var imageType: ImageType {
        didSet {
            let availableSizes = ImageSize.availableSizes(for: imageType)
            if !availableSizes.contains(imageSize) {
                imageSize = .large
            }
        }
    }
    var imageSize: ImageSize
    var compressionQuality: Double // 0.0 to 1.0 (recommend 0.8-0.9 for icons)
    var removeBackground: Bool
    
    init(showAlert: Bool = false,
         alertMessage: String = "Image saved successfully!",
         savedImage: UIImage? = nil,
         imageType: ImageType = ImageType.png,
         imageSize: ImageSize = ImageSize.large,
         compressionQuality: Double = 0.85,
         removeBackground: Bool = false // trasparecy
    ) {
        self.showAlert = showAlert
        self.alertMessage = alertMessage
        self.savedImage = savedImage
        self.imageType = imageType
        self.imageSize = imageSize
        self.compressionQuality = compressionQuality
        self.removeBackground = removeBackground
    }
    
    
    
    func processViewToImage(iconModel: IconModel) -> UIImage? {
        let renderer = createRender(for: iconModel)
        return renderer.uiImage
    }
    
    func createRender(for iconModel: IconModel) -> ImageRenderer<some View> {
        
        //var render = ImageRenderer()
        let renderer = ImageRenderer(content: IconView(vmIcon: iconModel, editable: false)
            .background(removeBackground ? Color.clear : iconModel.backgroundColor)
        )
        
        renderer.proposedSize = ProposedViewSize(
            width: CGFloat(imageSize.rawValue),
            height: CGFloat(imageSize.rawValue)
        )
        
        renderer.isOpaque = !removeBackground
        
        return renderer
    }
    
    func processViewToUrl(iconModel: IconModel) -> URL {
        let renderer = createRender(for: iconModel)
        
        var fileURL: URL = URL(fileURLWithPath: "")
        
        guard let uiImage = renderer.uiImage else {
            self.alertMessage = "Error rendering image"
            self.showAlert = true
            return fileURL
        }
        
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileName = iconModel.title.isEmpty ? "icon" : iconModel.title
        fileURL = tempDirectory.appendingPathComponent("\(fileName).\(imageType.rawValue)")
        
        do {
            switch imageType {
            case .png:
                guard let pngData = uiImage.pngData() else {
                    throw NSError(domain: "ImageConverter", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert to PNG"])
                }
                try pngData.write(to: fileURL)
                
            case .jpeg:
                guard let jpegData = uiImage.jpegData(compressionQuality: compressionQuality) else {
                    throw NSError(domain: "ImageConverter", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to convert to JPEG"])
                }
                try jpegData.write(to: fileURL)
                
            case .ico:
                guard let pngData = uiImage.pngData() else {
                    throw NSError(domain: "ImageConverter", code: 3, userInfo: [NSLocalizedDescriptionKey: "Failed to convert to ICO"])
                }
                let icoData = try createICOData(from: pngData, size: imageSize.rawValue)
                try icoData.write(to: fileURL)
            }
        } catch {
            fileURL = URL(fileURLWithPath: "")
            self.alertMessage = "Error sharing image: \(error.localizedDescription)"
            self.showAlert = true
        }
        
        return fileURL
    }
    
    func createICOData(from pngData: Data, size: Int) throws -> Data {
        var icoData = Data()

        // ICO header
        icoData.append(contentsOf: [0x00, 0x00, 0x01, 0x00, 0x01, 0x00])

        // Image entry
        let width = size <= 255 ? UInt8(size) : UInt8(0) // 0 means 256
        let height = size <= 255 ? UInt8(size) : UInt8(0)
        let colorCount = UInt8(0)
        let reserved = UInt8(0)
        let planes = UInt16(1)
        let bitCount = UInt16(32)
        let imageSize = UInt32(pngData.count)
        let imageOffset = UInt32(22)

        icoData.append(contentsOf: [width, height, colorCount, reserved])
        icoData.append(contentsOf: withUnsafeBytes(of: planes.littleEndian) { Data($0) })
        icoData.append(contentsOf: withUnsafeBytes(of: bitCount.littleEndian) { Data($0) })
        icoData.append(contentsOf: withUnsafeBytes(of: imageSize.littleEndian) { Data($0) })
        icoData.append(contentsOf: withUnsafeBytes(of: imageOffset.littleEndian) { Data($0) })

        // Image data
        icoData.append(pngData)

        return icoData
    }
}

/*
 
 
 @MainActor
 func convertViewAsImage(iconModel: IconModel, type: String) {
     //let size = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 2
     let size: CGFloat = 1024
     let renderer = ImageRenderer(content: IconView(vmIcon: iconModel, editable: false)
         .aspectRatio(1.0, contentMode: .fit)
     )
     
     if let uiImage = renderer.uiImage {
         UIImageWriteToSavedPhotosAlbum(uiImage, self, #selector(saveCompleted), nil)
         //let pngData = uiImage.pngData()
     }
 }
 
 @MainActor
 func shareViewAsImage(iconModel: IconModel) -> UIImage? {
     //let size = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 2
     let size: CGFloat = 1024
     let renderer = ImageRenderer(content: IconView(vmIcon: iconModel, editable: false)
         .aspectRatio(1.0, contentMode: .fit)
     )
     
     
     return renderer.uiImage
 }
 
 
 @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
     if let error = error {
                 
         self.alertMessage = "Error saving image: \(error.localizedDescription)"
             } else {
                 
                 self.alertMessage = "Image saved successfully in your Photo Library!"
             }
     self.showAlert = true
     }
 
 
 */
