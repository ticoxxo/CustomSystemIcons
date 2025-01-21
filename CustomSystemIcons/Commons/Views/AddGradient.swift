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
}

import SwiftUI
import SFSafeSymbols

@Observable
class ConfigRadientModel: Identifiable {
    var id = UUID()
    var test: [Color]
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
 */
