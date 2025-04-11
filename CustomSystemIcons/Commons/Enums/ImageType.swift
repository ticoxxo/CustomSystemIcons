//
//  ImageType.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 28/03/25.
//

enum ImageType: String, CaseIterable,Identifiable {
    case png
    case jpeg
    case ico
    var id: Self {self}
}
