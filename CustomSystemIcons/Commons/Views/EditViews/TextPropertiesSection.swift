//
//  TextPropertiesSection.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 17/02/26.
//
import SwiftUI

struct TextPropertiesSection: View {
    @Binding var model: TextModel
    @State private var expanded: Bool = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            Grid(alignment: .leading) {
                GridRow {
                    Text("Label.TextSection.Text")
                    TextField("\(model.text)",text: $model.text)
                        .onChange(of: model.text) { _, newValue in
                                model.text = String(newValue.prefix(12))
                            }
                }
                
                GridRow {
                    Text("Label.TextSection.Italic")
                    HStack {
                        Spacer()
                        Toggle("Is italic", isOn: $model.isItalic)
                            .labelsHidden()
                    }
                }
                
                GridRow {
                    Text("Label.TextSection.FontSize")
                    Slider(value: $model.fontSize, in: 0.05...0.9)
                }
                
                GridRow {
                    Text("Label.TextSection.FontWeight")
                    HStack {
                        Spacer()
                        Picker("Label.TextSection.FontWeight", selection: $model.fontWeight) {
                            ForEach(FontWeight.allCases, id: \.self) { text in
                                Text(text.description).tag(text)
                            }
                        }
                        .labelsHidden()
                    }
                }
                
                GridRow {
                    Text("Label.TextSection.FontDesign")
                    HStack {
                        Spacer()
                        Picker("Label.TextSection.FontDesign", selection: $model.fontDesign) {
                            ForEach(FontDesign.allCases, id: \.self) { text in
                                Text(text.description).tag(text)
                            }
                        }
                        .labelsHidden()
                       
                    }
                }
                
                GridRow {
                    Text("Label.TextSection.LetterSpacing")
                    Slider(value: $model.letterSpacing, in: 0.01...0.9)
                }
                
                GridRow {
                    Text("Label.TextSection.LineSpacing")
                    Slider(value: $model.lineSpacing, in: 0.01...0.9)
                }
                
                GridRow {
                    Text("Label.TextSection.Strikethrough")
                    HStack {
                        Spacer()
                        Toggle("Is strikethrough",isOn: $model.strikethrough)
                            .labelsHidden()
                    }
                }
                
                GridRow {
                    Text("Label.Generic.Color")
                    HStack {
                        Spacer()
                        CustomColorPicker(color: $model.strikethroughColorComputed)
                    }
                }
                
                GridRow {
                    Text("Label.TextSection.Underline")
                    HStack {
                        Spacer()
                        Toggle("Is strikethrough",isOn: $model.strikethrough)
                            .labelsHidden()
                    }
                }
                
                GridRow {
                    Text("Label.Generic.Color")
                    HStack {
                        Spacer()
                        CustomColorPicker(color: $model.strikethroughColorComputed)
                    }
                }
            }
            
            
        } label: {
            Text(titleString)
                .font(.headline)
        }
    }
    
    var titleString : String {
        String(localized: "Label.TextSection.Title") + " \(model.text)"
    }
}


#Preview {
    @Previewable @State var icon = TextModel.dataPreviewExample
    Form {
        TextPropertiesSection(model: $icon)
    }
}
