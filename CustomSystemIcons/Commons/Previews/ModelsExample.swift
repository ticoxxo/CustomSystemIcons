//
//  ModelsExample.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 19/02/26.
//
import SwiftUI

struct ModelsExample {
    static func singleIconModelExample() -> IconModel {
        let vmIcon = IconModel()
        vmIcon.backgroundColor = Color.blue
        vmIcon.borderWidth = 0.05
        vmIcon.shape.cornerRadio = 0.4
        vmIcon.title = "El texto de prueba"
        //vmIcon.backgroundImage.backgroundImage = ImageDataLoader.loadPreviewImage()
        return vmIcon
    }
}
