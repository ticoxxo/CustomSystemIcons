//
//  ColorNameEnum.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 02/03/26.
//
import SwiftUI

enum ColorName: String, CaseIterable, Identifiable {
    case black = "black"
    case white = "white"
    case gray = "gray"
    case grey = "grey"
    case charcoal = "charcoal"
    case slateGray = "slate gray"
    case steelGray = "steel gray"
    case silver = "silver"

    case red = "red"
    case lightRed = "light red"
    case darkRed = "dark red"
    case brightRed = "bright red"
    case deepRed = "deep red"
    case maroon = "maroon"
    case burgundy = "burgundy"
    case crimson = "crimson"
    case scarlet = "scarlet"
    case brickRed = "brick red"
    case cherryRed = "cherry red"
    case roseRed = "rose red"

    case orange = "orange"
    case lightOrange = "light orange"
    case darkOrange = "dark orange"
    case brightOrange = "bright orange"
    case burntOrange = "burnt orange"
    case amber = "amber"
    case tangerine = "tangerine"
    case apricot = "apricot"
    case peach = "peach"
    case coral = "coral"

    case yellow = "yellow"
    case lightYellow = "light yellow"
    case darkYellow = "dark yellow"
    case lemonYellow = "lemon yellow"
    case goldenYellow = "golden yellow"
    case mustard = "mustard"
    case gold = "gold"

    case green = "green"
    case lightGreen = "light green"
    case darkGreen = "dark green"
    case brightGreen = "bright green"
    case forestGreen = "forest green"
    case olive = "olive"
    case lime = "lime"
    case mint = "mint"
    case emerald = "emerald"
    case jade = "jade"
    case seaGreen = "sea green"

    case blue = "blue"
    case lightBlue = "light blue"
    case darkBlue = "dark blue"
    case skyBlue = "sky blue"
    case babyBlue = "baby blue"
    case powderBlue = "powder blue"
    case iceBlue = "ice blue"
    case royalBlue = "royal blue"
    case navyBlue = "navy blue"
    case steelBlue = "steel blue"
    case azure = "azure"
    case cobalt = "cobalt"
    case sapphire = "sapphire"
    case denim = "denim"

    case purple = "purple"
    case lightPurple = "light purple"
    case darkPurple = "dark purple"
    case violet = "violet"
    case lavender = "lavender"
    case lilac = "lilac"
    case plum = "plum"
    case grape = "grape"
    case eggplant = "eggplant"

    case pink = "pink"
    case lightPink = "light pink"
    case hotPink = "hot pink"
    case deepPink = "deep pink"
    case pastelPink = "pastel pink"
    case rosePink = "rose pink"
    case salmon = "salmon"

    case brown = "brown"
    case lightBrown = "light brown"
    case darkBrown = "dark brown"
    case tan = "tan"
    case beige = "beige"
    case cream = "cream"
    case ivory = "ivory"
    case chocolate = "chocolate"
    case coffee = "coffee"
    case mocha = "mocha"
    case caramel = "caramel"
    case cinnamon = "cinnamon"
    case chestnut = "chestnut"

    case cyan = "cyan"
    case aqua = "aqua"
    case turquoise = "turquoise"
    case teal = "teal"
    case seafoam = "seafoam"

    case magenta = "magenta"
    case fuchsia = "fuchsia"
    case indigo = "indigo"

    case bronze = "bronze"
    case copper = "copper"

    case blueGray = "blue gray"
    case blueGrey = "blue grey"
    case greenBlue = "green blue"
    case yellowGreen = "yellow green"
    case redOrange = "red orange"
    case bluePurple = "blue purple"
    case pinkPurple = "pink purple"
    case redPurple = "red purple"

    var id: String { rawValue }

    var searchText: String {
        let aliases = aliasTerms.joined(separator: " ")
        return "\(rawValue) \(aliases)".lowercased()
    }

    var value: Color {
        switch self {
        case .black:
            return .black
        case .white:
            return .white
        case .gray, .grey:
            return Color(white: 0.5)
        case .charcoal:
            return Color(white: 0.2)
        case .slateGray:
            return Color(white: 0.44)
        case .steelGray:
            return Color(white: 0.47)
        case .silver:
            return Color(white: 0.75)

        case .red:
            return Color(hue: 0.0, saturation: 1.0, brightness: 1.0)
        case .lightRed:
            return Color(hue: 0.0, saturation: 0.6, brightness: 1.0)
        case .darkRed:
            return Color(hue: 0.0, saturation: 1.0, brightness: 0.5)
        case .brightRed:
            return Color(hue: 0.0, saturation: 1.0, brightness: 1.0)
        case .deepRed:
            return Color(hue: 0.0, saturation: 1.0, brightness: 0.7)
        case .maroon:
            return Color(hue: 0.0, saturation: 0.7, brightness: 0.4)
        case .burgundy:
            return Color(hue: 0.98, saturation: 0.6, brightness: 0.4)
        case .crimson:
            return Color(hue: 0.97, saturation: 1.0, brightness: 0.86)
        case .scarlet:
            return Color(hue: 0.0, saturation: 0.9, brightness: 0.9)
        case .brickRed:
            return Color(hue: 0.02, saturation: 0.75, brightness: 0.65)
        case .cherryRed:
            return Color(hue: 0.98, saturation: 0.9, brightness: 0.8)
        case .roseRed:
            return Color(hue: 0.98, saturation: 0.45, brightness: 0.9)

        case .orange:
            return Color(hue: 0.08, saturation: 1.0, brightness: 1.0)
        case .lightOrange:
            return Color(hue: 0.08, saturation: 0.6, brightness: 1.0)
        case .darkOrange:
            return Color(hue: 0.07, saturation: 1.0, brightness: 0.7)
        case .brightOrange:
            return Color(hue: 0.08, saturation: 1.0, brightness: 1.0)
        case .burntOrange:
            return Color(hue: 0.06, saturation: 0.9, brightness: 0.8)
        case .amber:
            return Color(hue: 0.10, saturation: 1.0, brightness: 1.0)
        case .tangerine:
            return Color(hue: 0.08, saturation: 1.0, brightness: 1.0)
        case .apricot:
            return Color(hue: 0.08, saturation: 0.6, brightness: 1.0)
        case .peach:
            return Color(hue: 0.07, saturation: 0.45, brightness: 1.0)
        case .coral:
            return Color(hue: 0.02, saturation: 0.65, brightness: 1.0)

        case .yellow:
            return Color(hue: 0.15, saturation: 1.0, brightness: 1.0)
        case .lightYellow:
            return Color(hue: 0.15, saturation: 0.3, brightness: 1.0)
        case .darkYellow:
            return Color(hue: 0.15, saturation: 1.0, brightness: 0.7)
        case .lemonYellow:
            return Color(hue: 0.1639, saturation: 1.0, brightness: 1.0)
        case .goldenYellow:
            return Color(hue: 0.13, saturation: 1.0, brightness: 0.9)
        case .mustard:
            return Color(hue: 0.12, saturation: 0.8, brightness: 0.7)
        case .gold:
            return Color(hue: 0.13, saturation: 0.9, brightness: 0.85)

        case .green:
            return Color(hue: 0.33, saturation: 1.0, brightness: 1.0)
        case .lightGreen:
            return Color(hue: 0.33, saturation: 0.5, brightness: 1.0)
        case .darkGreen:
            return Color(hue: 0.33, saturation: 1.0, brightness: 0.45)
        case .brightGreen:
            return Color(hue: 0.33, saturation: 1.0, brightness: 1.0)
        case .forestGreen:
            return Color(hue: 0.33, saturation: 0.8, brightness: 0.5)
        case .olive:
            return Color(hue: 0.23, saturation: 0.7, brightness: 0.5)
        case .lime:
            return Color(hue: 0.27, saturation: 1.0, brightness: 1.0)
        case .mint:
            return Color(hue: 0.44, saturation: 0.4, brightness: 1.0)
        case .emerald:
            return Color(hue: 0.39, saturation: 0.8, brightness: 0.8)
        case .jade:
            return Color(hue: 0.44, saturation: 0.6, brightness: 0.8)
        case .seaGreen:
            return Color(hue: 0.45, saturation: 0.6, brightness: 0.7)

        case .blue:
            return Color(hue: 0.6, saturation: 1.0, brightness: 1.0)
        case .lightBlue:
            return Color(hue: 0.6, saturation: 0.4, brightness: 1.0)
        case .darkBlue:
            return Color(hue: 0.6, saturation: 1.0, brightness: 0.5)
        case .skyBlue:
            return Color(red: 0.4627, green: 0.8392, blue: 1.0)
        case .babyBlue:
            return Color(hue: 0.56, saturation: 0.3, brightness: 1.0)
        case .powderBlue:
            return Color(hue: 0.56, saturation: 0.2, brightness: 0.95)
        case .iceBlue:
            return Color(hue: 0.55, saturation: 0.2, brightness: 1.0)
        case .royalBlue:
            return Color(hue: 0.61, saturation: 1.0, brightness: 0.9)
        case .navyBlue:
            return Color(hue: 0.62, saturation: 1.0, brightness: 0.4)
        case .steelBlue:
            return Color(hue: 0.58, saturation: 0.4, brightness: 0.7)
        case .azure:
            return Color(hue: 0.56, saturation: 1.0, brightness: 1.0)
        case .cobalt:
            return Color(hue: 0.62, saturation: 1.0, brightness: 0.7)
        case .sapphire:
            return Color(hue: 0.62, saturation: 0.9, brightness: 0.65)
        case .denim:
            return Color(hue: 0.59, saturation: 0.6, brightness: 0.6)

        case .purple:
            return Color(hue: 0.75, saturation: 1.0, brightness: 0.85)
        case .lightPurple:
            return Color(hue: 0.75, saturation: 0.4, brightness: 1.0)
        case .darkPurple:
            return Color(hue: 0.75, saturation: 1.0, brightness: 0.5)
        case .violet:
            return Color(hue: 0.75, saturation: 0.8, brightness: 0.9)
        case .lavender:
            return Color(hue: 0.78, saturation: 0.3, brightness: 1.0)
        case .lilac:
            return Color(hue: 0.78, saturation: 0.4, brightness: 0.9)
        case .plum:
            return Color(hue: 0.78, saturation: 0.6, brightness: 0.7)
        case .grape:
            return Color(hue: 0.78, saturation: 0.8, brightness: 0.6)
        case .eggplant:
            return Color(hue: 0.76, saturation: 0.6, brightness: 0.4)

        case .pink:
            return Color(hue: 0.92, saturation: 0.7, brightness: 1.0)
        case .lightPink:
            return Color(hue: 0.92, saturation: 0.3, brightness: 1.0)
        case .hotPink:
            return Color(hue: 0.92, saturation: 1.0, brightness: 1.0)
        case .deepPink:
            return Color(hue: 0.92, saturation: 1.0, brightness: 0.8)
        case .pastelPink:
            return Color(hue: 0.92, saturation: 0.3, brightness: 1.0)
        case .rosePink:
            return Color(hue: 0.94, saturation: 0.5, brightness: 0.95)
        case .salmon:
            return Color(hue: 0.03, saturation: 0.6, brightness: 1.0)

        case .brown:
            return Color(hue: 0.07, saturation: 0.6, brightness: 0.5)
        case .lightBrown:
            return Color(hue: 0.07, saturation: 0.5, brightness: 0.7)
        case .darkBrown:
            return Color(hue: 0.07, saturation: 0.7, brightness: 0.3)
        case .tan:
            return Color(hue: 0.09, saturation: 0.4, brightness: 0.85)
        case .beige:
            return Color(hue: 0.10, saturation: 0.2, brightness: 0.95)
        case .cream:
            return Color(hue: 0.12, saturation: 0.1, brightness: 1.0)
        case .ivory:
            return Color(hue: 0.12, saturation: 0.1, brightness: 1.0)
        case .chocolate:
            return Color(hue: 0.06, saturation: 0.7, brightness: 0.4)
        case .coffee:
            return Color(hue: 0.06, saturation: 0.5, brightness: 0.3)
        case .mocha:
            return Color(hue: 0.07, saturation: 0.4, brightness: 0.5)
        case .caramel:
            return Color(hue: 0.08, saturation: 0.7, brightness: 0.7)
        case .cinnamon:
            return Color(hue: 0.06, saturation: 0.7, brightness: 0.6)
        case .chestnut:
            return Color(hue: 0.04, saturation: 0.6, brightness: 0.5)

        case .cyan:
            return Color(hue: 0.5, saturation: 1.0, brightness: 1.0)
        case .aqua:
            return Color(hue: 0.5, saturation: 1.0, brightness: 1.0)
        case .turquoise:
            return Color(hue: 0.5, saturation: 0.7, brightness: 0.9)
        case .teal:
            return Color(hue: 0.5, saturation: 0.7, brightness: 0.6)
        case .seafoam:
            return Color(hue: 0.45, saturation: 0.4, brightness: 0.9)

        case .magenta:
            return Color(hue: 0.83, saturation: 1.0, brightness: 1.0)
        case .fuchsia:
            return Color(hue: 0.83, saturation: 1.0, brightness: 1.0)
        case .indigo:
            return Color(hue: 0.67, saturation: 0.8, brightness: 0.6)

        case .bronze:
            return Color(hue: 0.08, saturation: 0.7, brightness: 0.6)
        case .copper:
            return Color(hue: 0.05, saturation: 0.8, brightness: 0.7)

        case .blueGray, .blueGrey:
            return Color(red: 0.55, green: 0.6, blue: 0.65)
        case .greenBlue:
            return Color(hue: 0.45, saturation: 0.8, brightness: 0.8)
        case .yellowGreen:
            return Color(hue: 0.25, saturation: 0.8, brightness: 0.9)
        case .redOrange:
            return Color(hue: 0.03, saturation: 1.0, brightness: 1.0)
        case .bluePurple:
            return Color(hue: 0.68, saturation: 0.8, brightness: 0.8)
        case .pinkPurple:
            return Color(hue: 0.85, saturation: 0.6, brightness: 0.9)
        case .redPurple:
            return Color(hue: 0.90, saturation: 0.8, brightness: 0.8)
        }
    }

    func matches(_ query: String) -> Bool {
        let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !normalizedQuery.isEmpty else { return false }
        if normalizedQuery.contains(rawValue) { return true }
        return aliasTerms.contains { normalizedQuery.contains($0) }
    }

    static func search(_ query: String) -> [ColorName] {
        allCases.filter { $0.matches(query) }
    }

    static func firstMatch(in text: String) -> (color: ColorName, range: Range<String.Index>)? {
        var earliest: (color: ColorName, range: Range<String.Index>)?

        for color in allCases {
            let terms = [color.rawValue] + color.aliasTerms
            for term in terms {
                let pattern = regexPattern(for: term)
                guard let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]) else {
                    continue
                }

                let fullRange = NSRange(text.startIndex..<text.endIndex, in: text)
                if let match = regex.firstMatch(in: text, options: [], range: fullRange),
                   let range = Range(match.range, in: text) {
                    if let current = earliest {
                        if range.lowerBound < current.range.lowerBound {
                            earliest = (color, range)
                        } else if range.lowerBound == current.range.lowerBound,
                                  range.upperBound > current.range.upperBound {
                            earliest = (color, range)
                        }
                    } else {
                        earliest = (color, range)
                    }
                }
            }
        }

        return earliest
    }

    private static func regexPattern(for term: String) -> String {
        let modifiers = ["light", "dark", "bright", "deep", "pale"]
        let words = term.split(separator: " ").map { String($0) }
        let joiner = "[-\\s]*"

        if words.count == 1 {
            let base = NSRegularExpression.escapedPattern(for: words[0])
            return "\\b\(base)(?:ish)?\\b"
        }

        let firstWord = words[0].lowercased()
        let escapedWords = words.map { NSRegularExpression.escapedPattern(for: $0) }

        if modifiers.contains(firstWord) {
            let modifierPattern = "\(escapedWords[0])(?:-?ish)?"
            let rest = escapedWords.dropFirst().joined(separator: joiner)
            return "\\b\(modifierPattern)\(joiner)\(rest)\\b"
        }

        let base = escapedWords.joined(separator: joiner)
        return "\\b\(base)\\b"
    }

    private var aliasTerms: [String] {
        switch self {
        case .gray:
            return ["grey"]
        case .grey:
            return ["gray"]
        case .aqua:
            return ["cyan"]
        case .cyan:
            return ["aqua"]
        case .fuchsia:
            return ["magenta", "fuschia"]
        case .magenta:
            return ["fuchsia"]
        case .turquoise:
            return ["turqoise", "turquiose", "turquise"]
        case .blueGray:
            return ["blue grey"]
        case .blueGrey:
            return ["blue gray"]
        default:
            return []
        }
    }
}


