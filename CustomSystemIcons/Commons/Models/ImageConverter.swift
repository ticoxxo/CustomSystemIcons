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
    func convertViewAsImage(iconModel: IconModel, type: String) {
        let size = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 2
        let renderer = ImageRenderer(content: IconView(vmIcon: iconModel, bWidth: size ,bHeight: size, editable: false)
            .aspectRatio(1.0, contentMode: .fit)
        )
        
        if let uiImage = renderer.uiImage {
            UIImageWriteToSavedPhotosAlbum(uiImage, self, #selector(saveCompleted), nil)
            //let pngData = uiImage.pngData()
        }
        /*
        if let uiImage = renderer.uiImage, let pngData = uiImage.pngData() {
                let fileName = "iconImage.png"
                if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let fileURL = documentDirectory.appendingPathComponent(fileName)
                    do {
                        try pngData.write(to: fileURL)
                        print("Image saved successfully at \(fileURL)")
                        self.alertMessage = "Image saved successfully at \(fileURL)"
                    } catch {
                        print("Error saving image: \(error.localizedDescription)")
                        self.alertMessage = "Error saving image: \(error.localizedDescription)"
                    }
                    self.showAlert = true
                }
            }
         */
    }
    
    @MainActor
    func shareViewAsImage(iconModel: IconModel) -> UIImage? {
        let size = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 2
        let renderer = ImageRenderer(content: IconView(vmIcon: iconModel, bWidth: size ,bHeight: size, editable: false)
            .aspectRatio(1.0, contentMode: .fit)
        )
        
        
        return renderer.uiImage
    }
    
    @MainActor
    func sharePng(iconModel: IconModel, type: ImageType) -> URL{
        let size = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 2
        let renderer = ImageRenderer(content: IconView(vmIcon: iconModel, bWidth: size ,bHeight: size, editable: false)
            .aspectRatio(1.0, contentMode: .fit)
        )
        var fileURL: URL = URL(fileURLWithPath: "")
        if let uiImage = renderer.uiImage, let pngData = uiImage.pngData() {
            let tempDirectory = FileManager.default.temporaryDirectory
            fileURL = tempDirectory.appendingPathComponent("\(iconModel.title.isEmpty ? "icon" : iconModel.title).\(type.rawValue)")
            do {
                if type == .png {
                    try pngData.write(to: fileURL)
                } else {
                    let icoData = try createICOData(from: pngData)
                    try icoData.write(to: fileURL)
                }
            } catch {
                fileURL = URL(fileURLWithPath: "")
                self.alertMessage = "Error sharing image"
                self.showAlert = true
            }
            
        }
        
        return fileURL
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
                    
            self.alertMessage = "Error saving image: \(error.localizedDescription)"
                } else {
                    
                    self.alertMessage = "Image saved successfully in your Photo Library!"
                }
        self.showAlert = true
        }
    
    func createICOData(from pngData: Data) throws -> Data {
        var icoData = Data()

        // ICO header
        icoData.append(contentsOf: [0x00, 0x00, 0x01, 0x00, 0x01, 0x00])

        // Image entry
        let width = UInt8(16)
        let height = UInt8(16)
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

