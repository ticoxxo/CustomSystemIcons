import SwiftUI
import SFSafeSymbols
import SwiftData

@Model
class IconModel: Identifiable {
    var id: UUID
    // Details
    var title: String
    var tareaName: String
    var status: Bool
    var styleShape: StyleShape
    // Date
    var startDate: Date
    var expireDate: Date
    // Color
    var backgroundColorComputed: Colores
    var borderColorComputed: Colores
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
    var gradientType: GradientType
    var borderWidth: CGFloat
    var position: CGPoint
    var dragging: Bool
    var icons: [IconChild]
    
    init(
        id: UUID = UUID(),
        title: String = "",
         tareaName: String = "",
         status: Bool = false,
        styleShape: StyleShape = .circle,
         startDate: Date = .now,
         expireDate: Date = Date.now.addingTimeInterval(86400),
        gradientType: GradientType = GradientType.linear,
         orientation: Double = 0.0,
         zoom: CGFloat = 0.8,
         borderWidth: CGFloat = 15.0,
        backgroundColorComputed: Colores = .init(),
        borderColorComputed: Colores = .init(red: 0.4,blue: 0.4,green: 0.4),
        position: CGPoint = .zero,
        dragging: Bool = false,
        icons: [IconChild] = [IconChild()]) {
        self.id = UUID()
        self.title = title
        self.tareaName = tareaName
        self.status = status
        self.styleShape = styleShape
        self.startDate = startDate
        self.expireDate = expireDate
        self.gradientType = gradientType
        self.borderWidth = borderWidth
        self.backgroundColorComputed = backgroundColorComputed
        self.borderColorComputed = borderColorComputed
        self.position = position
        self.dragging =  dragging
        self.icons = icons
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
    var backgroundColor: Color {
        get { Color(red: backgroundColorComputed.red, green: backgroundColorComputed.green, blue: backgroundColorComputed.blue)}
        set {
            if let components = newValue.cgColor?.components {
                backgroundColorComputed.red = components[0]
                backgroundColorComputed.green = components[1]
                backgroundColorComputed.blue = components[2]
            }
        }
    }
    
    var borderColor: Color {
        get { Color(red: borderColorComputed.red, green: borderColorComputed.green, blue: borderColorComputed.blue)}
        set {
            if let components = newValue.cgColor?.components {
                borderColorComputed.red = components[0]
                borderColorComputed.green = components[1]
                borderColorComputed.blue = components[2]
            }
        }
    }
    
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
    
    func addIcon() {
        let icon = IconChild()
        icon.zIndex = Double(self.icons.count) + 1.0
        self.icons.append(icon)
    }
    
    func moveRow(source: IndexSet, destination: Int) {
        self.icons.move(fromOffsets: source, toOffset: destination)
        updateZIndex()
    }
    
    func updateZIndex() {
        for (index, icon) in self.icons.enumerated() {
            icons[index].zIndex = Double(index) + 1.0
        }
    }
}


