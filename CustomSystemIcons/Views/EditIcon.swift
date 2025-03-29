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
    @Bindable var vmIcon: IconModel
    //typealias ancho = UIScene.current?.scree
    var widtho = UIScreen.current?.bounds.size.width ?? 0
    var heighto = UIScreen.current?.bounds.size.height ?? 0
    var body: some View {
        
        
        /*
         Form {
         ScrollView {
         VStack(alignment: .leading) {
         // Colors
         
         Section(header: Text("Colors").font(.headline)) {
         ColorPicker("Background", selection: $vmIcon.backgroundColor)
         /*
          HStack {
          Text("Foreground")
          
          ForEach($vmIcon.colorTest, id: \.self) { $color in
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
          
          
          
          }*/
         ColorPicker("Foreground",selection: $vmIcon.frontColor)
         ColorPicker("Border", selection: $vmIcon.borderColor)
         }
         
         Section(header: Text("Controls").font(.headline)) {
         HStack {
         Text("Orientation")
         Slider(
         value: $vmIcon.orientation,
         in: 0...100
         )
         }
         
         HStack {
         Text("Zoom")
         Slider(
         value: $vmIcon.zoom,
         in: 0...1
         )
         }
         
         HStack {
         Text("Border width")
         Slider(
         value: $vmIcon.borderWidth,
         in: 0...15
         )
         }
         }
         
         Section(header: Text("Estilos").font(.headline)) {
         HStack {
         Text("Gradient type")
         Picker("Claro", selection: $vmIcon.gradientType) {
         ForEach(GradientType.allCases, id: \.self) { type in
         Text("\(type)").textCase(.uppercase).tag(type)
         }
         }
         .pickerStyle(.menu)
         }
         HStack {
         Text("Style type")
         Picker("Pink", selection: $vmIcon.styleShape) {
         ForEach(StyleShape.allCases, id: \.self) { style in
         //Text(style.rawValue.capitalized)
         Text("\(style)").textCase(.uppercase).tag(style)
         }
         
         }
         
         }
         }
         }
         
         }
         }
         */
        VStack {
            
                VStack {
                    IconView(vmIcon: vmIcon,
                             bWidth: min(widtho, heighto),
                             bHeight: min(widtho, heighto),
                             editable: true)
                    
                    Form {
                        ColorSection(vmIcon: vmIcon)
                        ShapeSection(vmIcon: vmIcon)
                        OrientationSection(vmIcon: vmIcon)
                        PositionSection(vmIcon: vmIcon)
                        BorderSection(vmIcon: vmIcon)
                        Button {
                            //let num = coordinator.path.count > 2 ? 2 : 1
                            coordinator.pop()
                        } label: {
                            Text("Go Back")
                        }
                        
                    }
                }
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Icon") {
                    vmIcon.addIcon()
                }
                .disabled(vmIcon.icons.count > 5)
            }
        }
        
        //PositionSection(vmIcon: vmIcon)
    }
    
}

#Preview {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @State var vmIcon = IconModel()
    vmIcon.addIcon()
    vmIcon.addIcon()
    return NavigationStack(path: $coordinator.path) {
        EditIcon(vmIcon: vmIcon)
    }
    .environment(\.coordinator, coordinator)
}

