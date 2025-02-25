import SwiftUI
import SFSafeSymbols
import SwiftData

struct Colores: Codable, Hashable {
    var red: Double
    var blue: Double
    var green: Double
    
    init(red: Double = 0.85,
         blue: Double = 0.85,
         green: Double = 0.85) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

enum StyleShape: Int,CaseIterable , Codable, Shape {
    
    func createStar(corners: Int, smoothness: Double, path: inout Path, center: CGPoint, rect: CGRect) -> Path {
        
        var currentAngle = -CGFloat.pi / 2
        
        let angleAdjustment = .pi * 2 / Double(corners * 2)
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))
        var bottomEdge: Double = 0
        for corner in 0..<corners * 2  {
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: Double
            
            if corner.isMultiple(of: 2) {
                bottom = center.y * sinAngle
                
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                bottom = innerY * sinAngle
                
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }
            
            if bottom > bottomEdge {
                bottomEdge = bottom
            }
            
            currentAngle += angleAdjustment
        }

        let unusedSpace = (rect.height / 2 - bottomEdge) / 2

        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        path.closeSubpath()
        return path.applying(transform)
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        switch self {
        case .star:
            return createStar(corners: 5, smoothness: 0.45, path: &path, center: center, rect: rect)
            /*
             let corners: Int = 5
             let smoothness: Double = 0.44
                         
             let center = CGPoint(x: rect.width / 2, y: rect.height / 2)

             var currentAngle = -CGFloat.pi / 2
             
             let angleAdjustment = .pi * 2 / Double(corners * 2)
             let innerX = center.x * smoothness
             let innerY = center.y * smoothness
             path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))
             var bottomEdge: Double = 0
             for corner in 0..<corners * 2  {
                 let sinAngle = sin(currentAngle)
                 let cosAngle = cos(currentAngle)
                 let bottom: Double
                 
                 if corner.isMultiple(of: 2) {
                     bottom = center.y * sinAngle
                     
                     path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
                 } else {
                     bottom = innerY * sinAngle
                     
                     path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
                 }
                 
                 if bottom > bottomEdge {
                     bottomEdge = bottom
                 }
                 
                 currentAngle += angleAdjustment
             }

             let unusedSpace = (rect.height / 2 - bottomEdge) / 2

             let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
             return path.applying(transform)
             */
            
        case .circle:
            path.addEllipse(in: CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height))
            path.closeSubpath()
        case .square:
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        case .triangle:
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()
        case .hexagone:
            /*
             path.move(to: CGPoint(x: width * 0.5, y: 0))
             path.addLine(to: CGPoint(x: width, y: height * 0.25))
             path.addLine(to: CGPoint(x: width, y: height * 0.75))
             path.addLine(to: CGPoint(x: width * 0.5, y: height))
             path.addLine(to: CGPoint(x: 0, y: height * 0.75))
             path.addLine(to: CGPoint(x: 0, y: height * 0.25))
             */
            return createStar(corners: 6, smoothness: 0.6, path: &path, center: center, rect: rect)
            //path.closeSubpath()
        case .gearshape:
            /*
            let teeth: Int = 8
            let center = CGPoint(x: rect.midX, y: rect.midY)
                let outerRadius = min(rect.width, rect.height) / 2
                let innerRadius = outerRadius * 0.75
                let toothWidth = CGFloat.pi * 2 / CGFloat(teeth * 2)

                for i in 0..<(teeth * 2) {
                  let angle = toothWidth * CGFloat(i)
                  let radius = (i % 2 == 0) ? outerRadius : innerRadius
                  let point = CGPoint(
                    x: center.x + radius * cos(angle),
                    y: center.y + radius * sin(angle)
                  )

                  if i == 0 {
                    path.move(to: point)
                  } else {
                    path.addLine(to: point)
                  }
                }
            path.closeSubpath()
             */
            return createStar(corners: 8, smoothness: 0.6, path: &path, center: center, rect: rect)
        }
        
        return path
    }
    
    case star = 0
    case circle = 1
    case square = 2
    case triangle = 3
    case hexagone = 4
    case gearshape = 5
}

@Model
class IconModel: Identifiable {
    var id: UUID
    // Details
    var title: String
    var tareaName: String
    var iconSF: String
    var status: Bool
    var styleShape: StyleShape
    // Date
    var startDate: Date
    var expireDate: Date
    // Color
    var frontColorComputed: Colores
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
    var orientation: Double
    var zoom: CGFloat
    var borderWidth: CGFloat
    var position: CGPoint
    var dragging: Bool
    
    init(
        id: UUID = UUID(),
        title: String = "Test",
         tareaName: String = "",
        iconSF : String = "star.fill",
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
        frontColorComputed: Colores = .init(red: 0.0,blue: 0.4,green: 0.1),
        position: CGPoint = .zero,
        dragging: Bool = false) {
        self.id = UUID()
        self.title = title
        self.tareaName = tareaName
        self.iconSF = iconSF
        self.frontColorComputed = frontColorComputed
        self.status = status
        self.styleShape = styleShape
        self.startDate = startDate
        self.expireDate = expireDate
        self.gradientType = gradientType
        self.orientation = orientation
        self.zoom = zoom
        self.borderWidth = borderWidth
        self.backgroundColorComputed = backgroundColorComputed
        self.borderColorComputed = borderColorComputed
        self.frontColorComputed = frontColorComputed
        self.position = position
            self.dragging =  dragging
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
    
    var frontColor: Color {
        get { Color(red: frontColorComputed.red, green: frontColorComputed.green, blue: frontColorComputed.blue)}
        set {
            if let components = newValue.cgColor?.components {
                frontColorComputed.red = components[0]
                frontColorComputed.green = components[1]
                frontColorComputed.blue = components[2]
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
   
    func changePosition(width: CGFloat, height: CGFloat) -> CGPoint {
        if (self.position == .zero) {
            self.position.x = width / 2
            self.position.y = height / 2
        }
        
        return self.position
    }
}


