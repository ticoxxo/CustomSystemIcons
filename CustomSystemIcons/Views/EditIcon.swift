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
    var widtho = UIScreen.current?.bounds.size.width ?? 0
    var heighto = UIScreen.current?.bounds.size.height ?? 0
    var body: some View {
        
        
        VStack {
            
                VStack {
                    IconView(vmIcon: vmIcon,
                             bWidth: min(widtho, heighto) / 2,
                             bHeight: min(widtho, heighto) / 2,
                             editable: true)
                    .offset(
                        x: animateIcon ? 0 : horizontalPadding
                        ,y: animateIcon ? 0 : -verticalPadding)
                    
                    
                    Form {
                        ColorSection(vmIcon: vmIcon)
                        ShapeSection(vmIcon: vmIcon)
                        OrientationSection(vmIcon: vmIcon)
                        PositionSection(vmIcon: vmIcon)
                        BorderSection(vmIcon: vmIcon)
                    }
                    
                }
        }
        .offset(x: animateIcon ? 0 : -horizontalPadding)
        .transition(.scale)
        .onAppear {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                animateIcon = true
                            }
                        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    vmIcon.addIcon()
                } label: {
                    Label("Add Icon",systemImage: "plus.square.fill" )
                }
                .disabled(vmIcon.icons.count > 5)

            }
            
            ToolbarItemGroup(placement: .topBarLeading) {
                GoBackButton()
                Button() {
                    coordinator.toRoot()
                } label: {
                    Label("Home",systemImage: "house.fill" )
                }
            }
        }
        .navigationBarBackButtonHidden(true)
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

