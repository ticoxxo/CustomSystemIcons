//
//  AddGradient.swift
//  CustomSystemIcons
//
//  Created by Alberto Almeida on 15/01/25.
//

/*
 
 init(gradientType: GradientType = .linear) {
     self.gradientType = gradientType
 }
 
 func pickGradientType(to gradientType: GradientType ) {
    switch gradientType {
    case .linear:
        self.gradientType = LinearGradient(gradient: gradient, startPoint: GradientDirection.topLeft.unitPoint, endPoint: GradientDirection.bottom.unitPoint)
    case .radial:
        self.gradientType = LinearGradient(gradient: gradient, startPoint: GradientDirection.topLeft.unitPoint, endPoint: GradientDirection.bottom.unitPoint)
    case .angular:
        self.gradientType = LinearGradient(gradient: gradient, startPoint: GradientDirection.topLeft.unitPoint, endPoint: GradientDirection.bottom.unitPoint)
    case .elliptical:
        self.gradientType = LinearGradient(gradient: gradient, startPoint: GradientDirection.topLeft.unitPoint, endPoint: GradientDirection.bottom.unitPoint)
    }
}*/

import SwiftUI
import SFSafeSymbols

enum GradientDirection {
    case top
    case bottom
    case left
    case right
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case center

    // Computed property to return the corresponding UnitPoint for each case
    var unitPoint: UnitPoint {
        switch self {
        case .top:
            return UnitPoint(x: 0.5, y: 0)  // Top center
        case .bottom:
            return UnitPoint(x: 0.5, y: 1)  // Bottom center
        case .left:
            return UnitPoint(x: 0, y: 0.5)  // Left center
        case .right:
            return UnitPoint(x: 1, y: 0.5)  // Right center
        case .topLeft:
            return UnitPoint(x: 0, y: 0)    // Top-left corner
        case .topRight:
            return UnitPoint(x: 1, y: 0)    // Top-right corner
        case .bottomLeft:
            return UnitPoint(x: 0, y: 1)    // Bottom-left corner
        case .bottomRight:
            return UnitPoint(x: 1, y: 1)    // Bottom-right corner
        case .center:
            return UnitPoint(x: 0.5, y: 0.5) // Center
        }
    }
}


enum GradientType: ShapeStyle{
    case linear
    case radial
    case angular
    case elliptical
}

@Observable
class ConfigRadientModel: Identifiable {
    var id = UUID()
    var test: [Color] = []
    var gradient: Gradient {
        get {
            Gradient(colors: test)
        }
    }
    var gradientType: GradientType = .linear
    var background: Color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    
    init(test: [Color]) {
        self.test = test
    }
    
    func build(gradientType: GradientType) -> AnyShapeStyle {
            switch gradientType {
            case .linear:
                return AnyShapeStyle(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
            case .radial:
                return AnyShapeStyle(RadialGradient(gradient: gradient, center: .center, startRadius: 1, endRadius: 100))
            case .angular:
                return AnyShapeStyle(AngularGradient(gradient: gradient, center: .center))
            case .elliptical:
                return AnyShapeStyle(EllipticalGradient(gradient: gradient, center: .center))
        }
    }
    
    func addColor() {
        test.append(.red)
    }
}

struct AddGradient: View {
    @State var config = ConfigRadientModel(test: [.red, .blue])

    //@State private var bgColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    var body: some View {
        VStack {
            Image(systemSymbol: SFSymbol._8Lane)
                .background(
                    config.background
                )
                .foregroundStyle(
                    config.build(gradientType: .linear)
                )
                .font(.system(size: 100))
                .clipShape(Circle())
            AddColor(color: $config.background)
            List($config.test, id: \.self){ $color in
                HStack {
                    Text("New color")
                    AddColor(color: $color)
                }
            }
        }
    }
}

#Preview {
    AddGradient()
}
