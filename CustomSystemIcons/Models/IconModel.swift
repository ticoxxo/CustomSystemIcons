import SwiftUI
import SFSafeSymbols
import SwiftData


@Model
class IconModel: Identifiable {
    var id: UUID
    // Details
    var title: String
    var tareaName: String
    var iconSF: String
    var status: Bool
    // Date
    var startDate: Date
    var expireDate: Date
    // Color
    var frontColor: [UInt]
    var background: UInt
   /* var gradient: Gradient {
        get {
            Gradient(colors: frontColor)
        }
        set {
            let s = frontColor
            return frontColor = s
        }
    
    Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    }
    */
    var boderColor: UInt
    var gradientType: GradientType
    var orientation: Double
    var zoom: CGFloat
    var borderWidth: CGFloat
    
    init(
        id: UUID = UUID(),
        title: String = "Test",
         tareaName: String = "",
        iconSF : String = "star.fill",
        frontColor: [UInt] = [0xFF0000],
        background: UInt = 0xFF0000,
         status: Bool = false,
         startDate: Date = .now,
         expireDate: Date = Date.now.addingTimeInterval(86400),
        boderColor: UInt = 0xFF0000,
         gradientType: GradientType = GradientType.linear,
         orientation: Double = 0.0,
         zoom: CGFloat = 0.8,
         borderWidth: CGFloat = 0.0) {
        self.id = UUID()
        self.title = title
        self.tareaName = tareaName
        self.iconSF = iconSF
        self.frontColor = frontColor
        self.background = background
        self.status = status
        self.startDate = startDate
        self.expireDate = expireDate
        self.boderColor = boderColor
        self.gradientType = gradientType
        self.orientation = orientation
        self.zoom = zoom
        self.borderWidth = borderWidth
    }
 
}

extension IconModel {
    
    /*
    public static func == (lhs: IconModel, rhs: IconModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    */
    func buildGradient(gradientType: GradientType) -> AnyShapeStyle {
            switch gradientType {
            case .linear:
                return AnyShapeStyle(LinearGradient(gradient: Gradient(colors: [Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
            case .radial:
              // return AnyShapeStyle(RadialGradient(gradient: Gradient(colors: frontColor), center: .center, startRadius: 1, endRadius: 100))
                return AnyShapeStyle(RadialGradient(gradient: Gradient(colors: [Color.black]), center: .center, startRadius: 1, endRadius: 100))
            case .angular:
                return AnyShapeStyle(AngularGradient(gradient: Gradient(colors: [Color.black]), center: .center))
            case .elliptical:
                return AnyShapeStyle(EllipticalGradient(gradient: Gradient(colors: [Color.black]), center: .center))
        }
    }
    
    func buildIt(gradientType: GradientType) ->  AnyShapeStyle {
        if gradientType == .linear {
            AnyShapeStyle(LinearGradient(gradient: Gradient(colors: [Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
        } else if gradientType == .radial {
            AnyShapeStyle(RadialGradient(gradient: Gradient(colors: [Color.black]), center: .center, startRadius: 1, endRadius: 100))
        } else if gradientType == .angular {
            AnyShapeStyle(AngularGradient(gradient: Gradient(colors: [Color.black]), center: .center))
        } else {
            AnyShapeStyle(EllipticalGradient(gradient: Gradient(colors: [Color.black]), center: .center))
        }
    }
    
    // Add color to the foreground
    func addColor() {
        frontColor.append(0x000000)
    }
    
    func removeColor() {
        frontColor.remove(at: frontColor.count - 1)
    }
    
    func hour(_ startDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.hour, .minute], from: startDate)
        return components.hour ?? 0
    }
    
    func minutes() -> Int {
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        return components.minute ?? 0
    }
    
    func update<T>(keyPath: ReferenceWritableKeyPath<IconModel, T>, to value: T) {
        self[keyPath: keyPath] = value
        
    }
    
    
    
}


