import SwiftUI
import SFSafeSymbols
import SwiftData
import PhotosUI


@Model
final class IconModel: Identifiable {
    var id: UUID
    // Details
    var title: String
    var styleShape: StyleShape
    // Color
    var backgroundColorComputed: ColorComponents
    var borderColorComputed: ColorComponents
    var borderWidth: Double
    @Relationship(deleteRule: .cascade)
    var icons: [IconChild]
    @Attribute(originalName: "creation_date") var creationDate: Date
    var isFavorite: Bool
    @Relationship(deleteRule: .cascade)
    var backgroundImage: BackgroundImageModel
    @Relationship(deleteRule: .cascade)
    var shadows: ShadowModel
    var cornerRadio: CGFloat
    
    init(
        id: UUID = UUID(),
        title: String = "",
        styleShape: StyleShape = .square(radio: 10),
        orientation: Double = 0.0,
        zoom: CGFloat = 0.8,
        borderWidth: Double = 0.01,
        //backgroundColorComputed: Colores = .init(red: 0.4,blue: 0.4,green: 0.4),
        //borderColorComputed: Colores = .init(red: 0.4,blue: 0.4,green: 0.4),
        backgroundColorComputed: ColorComponents = ColorComponents(color: .white),
        borderColorComputed: ColorComponents = ColorComponents(color: .black),
        icons: [IconChild] = [IconChild()],
        creationDate: Date = Date(),
        is isFavorite: Bool = false,
        backgroundImage: BackgroundImageModel = BackgroundImageModel(),
        shadows: ShadowModel = ShadowModel(),
        cornerRadio: CGFloat = 10.0
    ) {
            self.id = UUID()
            self.title = title
            self.styleShape = styleShape
            self.borderWidth = borderWidth
            self.backgroundColorComputed = backgroundColorComputed
            self.borderColorComputed = borderColorComputed
            self.icons = icons
            self.creationDate = creationDate
            self.isFavorite = isFavorite
            self.backgroundImage = backgroundImage
            self.shadows = shadows
            self.cornerRadio = cornerRadio
        }
    
    enum CodingKeys: String, CodingKey {
            case id
            case title
            case tareaName
            //case styleShape
            case backgroundColorComputed
            case borderColorComputed
            case borderWidth
            case icons
            case creationDate
            case isFavorite
        case backgroundImage
            case shadows
        }
    
}

extension IconModel {
    
    /*
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
     */
    
    
    var backgroundColor: Color {
            get { backgroundColorComputed.color }
            set { backgroundColorComputed = ColorComponents(color: newValue) }
        }

        var borderColor: Color {
            get { borderColorComputed.color }
            set { borderColorComputed = ColorComponents(color: newValue) }
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
        for (index, _) in self.icons.enumerated() {
            self.icons[index].zIndex = Double(index) + 1.0
        }
    }
    
    func customMove(fromOffsets indices: IndexSet, toOffset newOffset: Int) {
        self.icons.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func removeIcon(at offsets: IndexSet) {
        self.icons.remove(atOffsets: offsets)
    }
    
    func removeSingleIcon(_ icon: IconChild) {
        self.icons.removeAll(where : { $0.id == icon.id })
    }
    
    func loadImageData(from item: PhotosPickerItem?) async {
            if let data = try? await item?.loadTransferable(type: Data.self) {
                self.backgroundImage.backgroundImage = data
            }
        }

}


