//
//  EditIcon.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 20/12/24.
//

import SwiftUI
import SFSafeSymbols

struct EditIcon: View {
    @Environment(\.coordinator) var coordinator
    //@Binding var vmIcon: SFSymbol
    @Binding var vmIcon: IconModel
    let columns = [
        GridItem(.fixed(100)),
        GridItem(.flexible(minimum: 200, maximum: .infinity)),
    ]
    var body: some View {
        VStack {
            IconView(vmIcon: vmIcon)
                .frame(width: 400, height: 400)
            GroupBox("Settings") {
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        // Colors
                        HStack {
                            Text("Background")
                            ColorPicker("",selection: $vmIcon.background)
                        }
                        .labelsHidden()
                        HStack {
                            Text("Foreground")
                            ForEach($vmIcon.frontColor, id: \.self) { $color in
                                HStack {
                                    ColorPicker("",selection: $color)
                                }
                                .labelsHidden()
                            }
                            Button {
                                vmIcon.addColor()
                            } label: {
                                Image(systemName: "plus")
                            }
                            .opacity(vmIcon.frontColor.count > 2 ? 0 : 1 )
                            Button {
                                vmIcon.removeColor()
                            } label: {
                                Image(systemName: "minus")
                            }
                            .opacity(vmIcon.frontColor.count <= 1 ? 0 : 1 )
                        }
                        HStack {
                            Text("Border")
                            ColorPicker("", selection: $vmIcon.boderColor)
                                .labelsHidden()
                        }
                        // Orientations
                        HStack {
                           Text("Orientation")
                            Slider(
                                value: $vmIcon.orientation,
                                in: 0...100
                            )
                        }
                       // Zoom
                        HStack {
                           Text("Zoom")
                            Slider(
                                value: $vmIcon.zoom,
                                in: 0...1
                            )
                        }
                        // Border
                        HStack {
                           Text("Border width")
                            Slider(
                                value: $vmIcon.borderWidth,
                                in: 0...15
                            )
                        }
                        
                        HStack {
                            Text("Gradient type: \(vmIcon.gradientType)")
                           
                                Picker("Claro", selection: $vmIcon.gradientType) {
                                    ForEach(GradientType.all) { type in
                                        Text("\(type)").textCase(.uppercase)
                                    }
                                }
                                .pickerStyle(.menu)
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Button {
                let num = coordinator.path.count > 2 ? 2 : 1
                coordinator.popByNumber(num)
            } label: {
               Text("Go Back")
            }
        }
    }
}

#Preview {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @State var vmIcon = IconModel()
    NavigationStack(path: $coordinator.path) {
        EditIcon(vmIcon: $vmIcon)
    }
    .environment(\.coordinator, coordinator)
}

