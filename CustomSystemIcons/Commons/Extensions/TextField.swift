//
//  TextField.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 07/04/25.
//
import SwiftUI

struct CustomTextFieldStyle: ViewModifier {
    var label: String
    var hint: String
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray4), lineWidth: 1)
                    .overlay(alignment: .trailing) {
                        Image(systemName: "x.circle")
                            .resizable()
                            .opacity(text.isEmpty ? 0 : 1)
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .onTapGesture {
                                text.removeAll()
                            }
                    }
            )
            .accessibility(label: Text(label))
            .accessibility(hint: Text(hint))
            .accessibilityAddTraits(.isSearchField)
    }
}

extension TextField {
    func customAccessibility(label: String, hint: String) -> some View {
        let label = NSLocalizedString(label, comment: "")
        let hint = NSLocalizedString(hint, comment: "")
        
        return self.accessibilityLabel(Text(label))
            .accessibilityHint(Text(hint))
            .dynamicTypeSize(.large ... .accessibility3)
    }
}

extension View {
    func customTextField(label: String, hint: String, text: Binding<String>) -> some View {
        self.modifier(CustomTextFieldStyle(label: label, hint: hint, text: text))
    }
}

/*
 
 .accessibilityElement(children: .combine)
 .accessibilityLabel(Text(label))
 .accessibilityHint(Text(hint))
 .dynamicTypeSize(.large ... .accessibility3)
 .accessibilityAddTraits(.isButton)
 */
