//
//  CustomAlert.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 25/03/25.
//

import SwiftUI

struct CustomAlertView: View {
    var message: String
    var image: UIImage?
    var onDismiss: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            if let image = image?.resized(to: CGSize(width: 100, height: 100)) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            Text(message)
                .font(.subheadline)
                .customAccessibility(label: "Message in alert: \(message)", hint: "Alert message")
            HStack {
                Button{
                    onDismiss()
                } label: {
                    Text("Label.OK")
                        .bold()
                        .frame(minWidth: 100)
                        .padding()
                        .background(.white)
                        .foregroundColor(Color.blue)
                        .cornerRadius(10)
                    
                }
                .customAccessibility(label: "Label.OK.Accessibility", hint: "Label.Ok.Accessibility.Hint")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(maxWidth: 300)
    }
}

#Preview {
    var boolHandler = false
    CustomAlertView(message: "Se guardo la imagen", image: UIImage(systemName:  "exclamationmark.triangle.fill"), onDismiss: { boolHandler.toggle() } )
}
