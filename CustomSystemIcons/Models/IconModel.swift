import SwiftUI
import SFSafeSymbols


@Observable
class IconModel: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var icon: SFSymbol
    
    init() {
        title = ""
        description = ""
        icon = SFSymbol.star
    }
}
