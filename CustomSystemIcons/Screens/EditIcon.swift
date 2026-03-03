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
    @State private var animateIcon = false
    //typealias ancho = UIScene.current?.scree
    //var widtho = UIScreen.current?.bounds.size.width ?? 0
    //var heighto = UIScreen.current?.bounds.size.height ?? 0
    var body: some View {
        
        
        VStack {
            GroupBox(label: Text("GroupBox.Title.Icon")) {
                IconView(vmIcon: vmIcon,
                         editable: true)
                .padding()
            }
            Form {
                ColorSection(vmIcon: vmIcon)
                textSection
                ShapeSection(vmIcon: vmIcon)
                OrientationSection(vmIcon: vmIcon)
                PositionSection(vmIcon: vmIcon)
                DistortionSection(vmIcon: vmIcon)
                BorderSection(vmIcon: vmIcon)
                ShadowSection(vmIcon: vmIcon)
                ManualPositionSection(vmIcon: vmIcon)
            
            }
        }
        .offset(x: animateIcon ? 0 : -horizontalPadding)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                animateIcon = true
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(action: addIcon) {
                    Label("Label.AddIcon",systemImage: "xmark.triangle.circle.square.fill" )
                }
                .customAccessibility(label: "Label.AddIcon.Accessibility", hint: "Click to add a new icon")
                .disabled(vmIcon.icons.count > 15)
                Button(action: addText) {
                    Label("Label.AddIcon",systemImage: "character.square.fill")
                }
                .customAccessibility(label: "Label.AddIcon.Accessibility", hint: "Click to add a new icon")
                .disabled(vmIcon.icons.count > 15)
                
            }
            
            ToolbarItemGroup(placement: .topBarLeading) {
                GoBackButton()
                Button(action: goHome) {
                    Label("Button.Home",systemImage: "house.fill" )
                }
                .customAccessibility(label: "Button.Home.Accessibility", hint: "Go back to Home screen")
                
            }
        }
        .navigationBarBackButtonHidden(true)
        //PositionSection(vmIcon: vmIcon)
    }
    
    @ViewBuilder
    private var textSection:  some View {
        ForEach(textIconIDs, id: \.self) { iconID in
            if let binding = textPropertiesBinding(for: iconID) {
                TextPropertiesSection(model: binding)
            }
        }
    }

    private var textIconIDs: [UUID] {
        vmIcon.icons.filter { !$0.isIcon }.map(\.id)
    }

    private var iconIndexByID: [UUID: Int] {
        Dictionary(uniqueKeysWithValues: vmIcon.icons.enumerated().map { ($0.element.id, $0.offset) })
    }

    private func textPropertiesBinding(for iconID: UUID) -> Binding<TextModel>? {
        guard let index = iconIndexByID[iconID] else {
            return nil
        }
        return $vmIcon.icons[index].textProperties
    }

    private func addIcon() {
        vmIcon.addIcon()
    }

    private func addText() {
        vmIcon.addText()
    }

    private func goHome() {
        coordinator.toRoot()
    }
}

#Preview("Ipad") {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @State var vmIcon = IconModel()
    //vmIcon.addIcon()
    //vmIcon.addIcon()
    return NavigationStack(path: $coordinator.path) {
        EditIcon(vmIcon: vmIcon)
    }
    .environment(\.coordinator, coordinator)
}

#Preview("Ipad Horizontal", traits: .landscapeLeft) {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @State var vmIcon = IconModel()
    vmIcon.addIcon()
    vmIcon.addIcon()
    return NavigationStack(path: $coordinator.path) {
        EditIcon(vmIcon: vmIcon)
    }
    .environment(\.coordinator, coordinator)
}

#Preview("Iphone") {
    @Previewable @State var coordinator = Coordinator()
    @Previewable @State var vmIcon = IconModel()
    vmIcon.addIcon()
    vmIcon.addIcon()
    return NavigationStack(path: $coordinator.path) {
        EditIcon(vmIcon: vmIcon)
    }
    .environment(\.coordinator, coordinator)
}
