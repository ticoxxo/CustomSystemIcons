import SwiftUI
import SFSafeSymbols
import SwiftData
import PhotosUI


@Model
final class IconModel: Identifiable {
    var id: UUID
    // Details
    var title: String
    var shape: Figura
    // Color
    var backgroundColorComputed: ColorComponents
    var borderColorComputed: ColorComponents
    var borderWidth: CGFloat
    @Relationship(deleteRule: .cascade)
    var icons: [IconChild]
    @Attribute(originalName: "creation_date") var creationDate: Date
    var isFavorite: Bool
    @Relationship(deleteRule: .cascade)
    var backgroundImage: BackgroundImageModel
    @Relationship(deleteRule: .cascade)
    var shadows: ShadowModel
    
    
    init(
        id: UUID = UUID(),
        title: String = "",
        shape: Figura = Figura(),
        orientation: Double = 0.0,
        zoom: CGFloat = 0.8,
        borderWidth: CGFloat = 0.0,
        //backgroundColorComputed: Colores = .init(red: 0.4,blue: 0.4,green: 0.4),
        //borderColorComputed: Colores = .init(red: 0.4,blue: 0.4,green: 0.4),
        // ... other parameters
        backgroundColorComputed: ColorComponents = ColorComponents(color: .white),
        // white
        borderColorComputed: ColorComponents = ColorComponents(color: .white),
        // black
        // ... rest
        icons: [IconChild] = [IconChild()],
        creationDate: Date = Date(),
        isFavorite: Bool = false,
        backgroundImage: BackgroundImageModel = BackgroundImageModel(),
        shadows: ShadowModel = ShadowModel()
    ) {
        self.id = UUID()
        self.title = title
        self.shape = shape
        self.borderWidth = borderWidth
        self.backgroundColorComputed = backgroundColorComputed
        self.borderColorComputed = borderColorComputed
        self.icons = icons
        self.creationDate = creationDate
        self.isFavorite = isFavorite
        self.backgroundImage = backgroundImage
        self.shadows = shadows
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case tareaName
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
    
    
    
    // Colors
    var backgroundColor: Color {
        get { backgroundColorComputed.color }
        set {
            backgroundColorComputed.setColor(newValue)
        }
    }

    var borderColor: Color {
        get { borderColorComputed.color }
        set { borderColorComputed.setColor(newValue) }
    }
    
    
    func hour(_ startDate: Date) -> Int {
        let components = Calendar.current.dateComponents(
            [.hour, .minute],
            from: startDate
        )
        return components.hour ?? 0
    }
    
    func minutes() -> Int {
        let components = Calendar.current.dateComponents(
            [.hour, .minute],
            from: Date.now
        )
        return components.minute ?? 0
    }
    
    func update<T>(
        keyPath: ReferenceWritableKeyPath<IconModel, T>,
        to value: T
    ) {
        self[keyPath: keyPath] = value
    }
    
    func addIcon(_ child: IconChild? = nil) {
        if let child = child {
            child.zIndex = nextIndex()
            self.icons.append(child)
        } else {
            let icon = IconChild()
            icon.zIndex = nextIndex()
            self.icons.append(icon)
        }
        
    }
    
    func addText() {
        let zIndex = nextIndex()
        let iconChild = IconChild(zIndex: zIndex,isIcon: false,textProperties: TextModel())
        self.icons.append(iconChild)
    }
    
    private func nextIndex() -> Double {
        Double(self.icons.count) + 1.0
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
        updateZIndex()
    }
    
    func removeSingleIcon(_ icon: IconChild) {
        self.icons.removeAll(where : { $0.id == icon.id })
    }
    
    func loadImageData(from item: PhotosPickerItem?) async {
        if let data = try? await item?.loadTransferable(type: Data.self) {
            self.backgroundImage.backgroundImage = data
        }
    }

    var iconsSorted: [IconChild] {
        get {
            self.icons.sorted { $0.zIndex < $1.zIndex }
        }
        
        set {
            self.icons = newValue
        }
    }
}


