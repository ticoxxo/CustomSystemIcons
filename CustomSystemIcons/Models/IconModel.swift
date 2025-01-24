import SwiftUI
import SFSafeSymbols


@Observable
class IconModel: Identifiable, Hashable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var icon: SFSymbol
    var status: Bool = false
    var date: Date = Date.now
    var expires: Date?
    var frontColor: [Color] = [.red, .blue]
    var background: Color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    var gradient: Gradient {
        get {
            Gradient(colors: frontColor)
        }
        set {
            let s = frontColor
            return frontColor = s
        }
    }
    var boderColor: Color = .black
    var gradientType: GradientType = .linear
    var orientation: Double = 0.0
    var zoom: CGFloat = 0.8
    var borderWidth: CGFloat = 0.0
    
    init() {
        title = ""
        description = ""
        icon = SFSymbol.star
    }
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
        icon = SFSymbol.star
    }
 
}

extension IconModel {
    
    static func == (lhs: IconModel, rhs: IconModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func buildGradient(gradientType: GradientType) -> AnyShapeStyle {
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
    
    func buildIt(gradientType: GradientType) ->  AnyShapeStyle {
        if gradientType == .linear {
            AnyShapeStyle(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
        } else if gradientType == .radial {
            AnyShapeStyle(RadialGradient(gradient: gradient, center: .center, startRadius: 1, endRadius: 100))
        } else if gradientType == .angular {
            AnyShapeStyle(AngularGradient(gradient: gradient, center: .center))
        } else {
            AnyShapeStyle(EllipticalGradient(gradient: gradient, center: .center))
        }
    }
    
    // Add color to the foreground
    func addColor() {
        frontColor.append(.red)
    }
    
    func removeColor() {
        frontColor.remove(at: frontColor.count - 1)
    }
}
