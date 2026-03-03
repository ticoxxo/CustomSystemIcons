//
//  ShapedNameEnum.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 02/03/26.
//

import Foundation
import SwiftUI

enum ShapedName: String, CaseIterable, Identifiable {
    case star = "star"
    case circle = "circle"
    case rectangle = "rectangle"
    case triangle = "triangle"
    case hexagon = "hexagon"
    case gearshape = "gearshape"
    case pentagon = "pentagon"
    case heptagon = "heptagon"
    case octagon = "octagon"
    case nonagon = "nonagon"
    case decagon = "decagon"

    var id: String { rawValue }

    var figura: Figura {
        switch self {
        case .star:
            return Figura(selectedPath: .star)
        case .circle:
            return Figura(selectedPath: .circle)
        case .rectangle:
            return Figura(selectedPath: .rectangle)
        case .triangle:
            return Figura(selectedPath: .custom, corners: 3)
        case .pentagon:
            return Figura(selectedPath: .custom, corners: 5)
        case .hexagon:
            return Figura(selectedPath: .custom, corners: 6)
        case .heptagon:
            return Figura(selectedPath: .custom, corners: 7)
        case .octagon:
            return Figura(selectedPath: .custom, corners: 8)
        case .nonagon:
            return Figura(selectedPath: .custom, corners: 9)
        case .decagon:
            return Figura(selectedPath: .custom, corners: 10)
        case .gearshape:
            return Figura(selectedPath: .custom, corners: 9)
        }
    }

    static func firstMatch(in text: String) -> (shape: ShapedName, range: Range<String.Index>)? {
        var earliest: (shape: ShapedName, range: Range<String.Index>)?

        for shape in allCases {
            let terms = [shape.rawValue] + shape.aliasTerms
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
                            earliest = (shape, range)
                        } else if range.lowerBound == current.range.lowerBound,
                                  range.upperBound > current.range.upperBound {
                            earliest = (shape, range)
                        }
                    } else {
                        earliest = (shape, range)
                    }
                }
            }
        }

        return earliest
    }

    private static func regexPattern(for term: String) -> String {
        let words = term.split(separator: " ").map { String($0) }
        let joiner = "[-\\s]*"

        if words.count == 1 {
            let base = NSRegularExpression.escapedPattern(for: words[0])
            return "\\b\(base)(?:-?ish)?(?:s|es)?\\b"
        }

        let escapedWords = words.map { NSRegularExpression.escapedPattern(for: $0) }
        let base = escapedWords.joined(separator: joiner)
        return "\\b\(base)\\b"
    }

    private var aliasTerms: [String] {
        switch self {
        case .circle:
            return ["round", "circular", "circulo", "redondo", "rueda"]
        case .rectangle:
            return ["square", "rect", "quadrilateral", "box", "stadium", "rectangulo"]
        case .triangle:
            return ["triangular", "tri"]
        case .pentagon:
            return ["penta"]
        case .hexagon:
            return ["hex"]
        case .heptagon:
            return ["hepta"]
        case .octagon:
            return ["octa"]
        case .nonagon:
            return ["nona"]
        case .decagon:
            return ["deca"]
        case .star:
            return ["astar", "strar", "starr"]
        case .gearshape:
            return ["gear", "gear shape", "cog", "cogwheel"]
        }
    }
}
