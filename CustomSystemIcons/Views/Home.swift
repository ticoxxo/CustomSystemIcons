//
//  Home.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 16/12/24.
//

import SwiftUI

struct Home: View {
    @Environment(\.coordinator) var coordinator
    @State var list = IconsListModel()
    
    init() {
        list.arrayOfIcons.append(IconModel(title: "Claro", description: "Clarooo asdad eee"))
        list.arrayOfIcons.append(IconModel(title: "Llamar a la peluqueria", description: "Bar Simpson"))
        list.arrayOfIcons.append(IconModel(title: "Ire a la playa", description: "Bar Simpson para que conmigo te quedes un ratito"))
        list.arrayOfIcons.append(IconModel(title: "Claro", description: "Clarooo asdad eee"))
        list.arrayOfIcons.append(IconModel(title: "Llamar a la peluqueria", description: "Bar Simpson"))
        list.arrayOfIcons.append(IconModel(title: "Ire a la playa", description: "Bar Simpson para que conmigo te quedes un ratito"))
    }
    var body: some View {
        VStack {
            if list.arrayOfIcons.isEmpty {
                Text("No hay tareas")
            } else {
                    List($list.arrayOfIcons, id: \.self) { $tarea in
                        IconRowView(icon: $tarea)
                            .onTapGesture {
                                coordinator.push(page: .AddIcon(list: $list,vmIcon: $tarea))
                            }
                    }
                
            }
            Button {
                @State var icon = IconModel()
                coordinator.push(page: .AddIcon(list: $list, vmIcon: $icon))
            } label: {
                Image(systemName: "plus.app")
                Text("Add Icon")
            }
        }
    }
}

#Preview {
    @Previewable @State var coordinator = Coordinator()
    NavigationStack(path: $coordinator.path) {
        coordinator.build(page: .Home)
            .navigationDestination(for: AppPage.self) { page in
                coordinator.build(page: page)
            }
    }
    .environment(\.coordinator, coordinator)
}
