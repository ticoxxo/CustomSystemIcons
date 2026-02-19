//
//  GridIconsView.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 18/12/24.
//

import SwiftUI
import SFSafeSymbols

struct GridIconsView: View {
    @Environment(\.coordinator) var coordinator
    @State private var iconsList: IconsListModel = IconsListModel()
    @State private var searchText = String()
    
    @Binding var vmIcon: IconChild
    
    
    var body: some View {
        VStack {
            TextField("Label.Search", text: $searchText)
                .customTextField(label: "Label.Search.Accessibility", hint: "Label.Search.Accessibility.Hint", text: $searchText)
                .frame(maxWidth: .infinity)
                .padding()
            CustomAdaptiveGrid(columns: nil) {
                symbolsCollection
            }
            .onChange(of: searchText) {
                iconsList.search(searchText)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                GoBackButton()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    @ViewBuilder
    var symbolsCollection: some View {
        ForEach(iconsList.symbolsList, id: \.self) { icon in
            Image(systemName: icon.rawValue)
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 40, maxWidth: 60, minHeight: 40, maxHeight: 60)
                .padding(8)
                .onTapGesture {
                            vmIcon.name = icon.rawValue
                            coordinator.pop()
                        }
                
        }
        .visualEffect { content, geometryProxy in
            let frame = geometryProxy.frame(in: .scrollView)
            let scrollViewHeight = geometryProxy.bounds(of: .scrollView)?.height ?? 0
            let fadeDistance: CGFloat = 50
            var opacityValue = 1.0
            if frame.maxY > scrollViewHeight - fadeDistance {
                let distanceFromBottom = scrollViewHeight - frame.minY
                opacityValue = max(0, min(1, distanceFromBottom / fadeDistance))
            }
            
            
            return content
                .opacity(opacityValue)
        }
        
    }
    
}

/*
 ForEach(iconsList, id: \.self) { icon in
     Image(systemName: "\(icon)")
         .resizable()
         .customAccessibility(label: "Icon \(icon)", hint: "Press to select icon", isButton: true)
         .scaledToFit()
         .onTapGesture {
             vmIcon.name = icon
             coordinator.pop()
         }
 }
 .onChange(of: searchText){
     iconsList.filterIcons(searchText)
 }
 */

#Preview("Vertical") {
    @Previewable @State var coordinator = Coordinator()
    @Previewable let list = IconsListModel()
    @Previewable @State var vmIcon = IconChild()
    NavigationStack(path: $coordinator.path) {
        GridIconsView(vmIcon: $vmIcon)
    }
    .environment(\.coordinator, coordinator)
}

#Preview("Landscape", traits: .landscapeLeft) {
    @Previewable @State var coordinator = Coordinator()
    @Previewable let list = IconsListModel()
    @Previewable @State var vmIcon = IconChild()
    NavigationStack(path: $coordinator.path) {
        GridIconsView(vmIcon: $vmIcon)
    }
    .environment(\.coordinator, coordinator)
}
/*
 @Previewable @State var coordinator = Coordinator()
 NavigationStack(path: $coordinator.path) {
     coordinator.build(page: .home)
         .navigationDestination(for: AppPage.self) { page in
             coordinator.build(page: page)
         }
         .sheet(item: $coordinator.sheet ) { sheet in
             coordinator.buildSheet(sheet: sheet)
         }
 }
 .environment(\.coordinator, coordinator)
 */
