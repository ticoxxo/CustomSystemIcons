//
//  BackgroundView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 08/04/25.
//

import SwiftUI

struct BackgroundView: View {
    var background: BackgroundImageModel
    
    var body: some View {
        GeometryReader { geometry in
            if let img = background.backgroundImage, let ui = UIImage(data: img) {
                Image(uiImage: ui)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .position(
                        x: max(0, min(geometry.size.width, background.positionX == 0 ? geometry.size.width / 2 : geometry.size.width * background.positionX)),
                        y: max(0, min(geometry.size.height, background.positionY == 0 ? geometry.size.height / 2 : geometry.size.height * background.positionY)
                              )
                    )
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                background.positionX = value.location.x / geometry.size.width
                                background.positionY = value.location.y / geometry.size.height
                                background.dragging = true
                            }
                            .onEnded {_ in 
                                background.dragging = false
                            }
                    )
                    .simultaneousGesture(
                        MagnifyGesture()
                            .onChanged { value in
                                if value.magnification < 0.2 || value.magnification > 1.0 {
                                    background.zoom = Float(value.magnification)
                                }
                            }
                    )
                    .accessibilityZoomAction { action in
                        switch action.direction {
                        case .zoomIn:
                            background.zoom = Float(background.zoom + 0.1)
                        case .zoomOut:
                            background.zoom = Float(background.zoom - 0.1)
                        }
                    }
                    .accessibilityAction(named: Text("Drag.Right")) {
                        background.positionX = background.positionX + 0.1
                    }
                    .accessibilityAction(named: Text("Drag.Left")) {
                        background.positionX = background.positionX - 0.1
                    }
                    .accessibilityAction(named: Text("Drag.Top")) {
                        background.positionX = background.positionY + 0.1
                    }
                    .accessibilityAction(named: Text("Drag.Bottom")) {
                        background.positionX = background.positionY - 0.1
                    }
            } else {
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    let sampleImage = UIImage(systemName: "star.fill")?.pngData()
    // Replace with your image name
    let backgroundModel = BackgroundImageModel(
            backgroundImage: sampleImage,
            positionX: 0.5,
            positionY: 0.5
        )
    BackgroundView(background: backgroundModel)
}
