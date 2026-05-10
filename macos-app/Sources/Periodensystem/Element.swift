import SwiftUI

enum ElementCategory: String, CaseIterable, Hashable {
    case nonmetal
    case noblegas
    case alkali
    case alkaline
    case transition
    case posttransition
    case metalloid
    case halogen
    case lanthanide
    case actinide
    case unknown

    var displayName: String {
        switch self {
        case .nonmetal: return "Nichtmetall"
        case .noblegas: return "Edelgas"
        case .alkali: return "Alkalimetall"
        case .alkaline: return "Erdalkalimetall"
        case .transition: return "Übergangsmetall"
        case .posttransition: return "Hauptgruppenmetall"
        case .metalloid: return "Halbmetall"
        case .halogen: return "Halogen"
        case .lanthanide: return "Lanthanoid"
        case .actinide: return "Actinoid"
        case .unknown: return "unbekannt"
        }
    }

    var legendName: String {
        switch self {
        case .nonmetal: return "Nichtmetalle"
        case .noblegas: return "Edelgase"
        case .alkali: return "Alkalimetalle"
        case .alkaline: return "Erdalkalimetalle"
        case .transition: return "Übergangsmetalle"
        case .posttransition: return "Hauptgruppenmetalle"
        case .metalloid: return "Halbmetalle"
        case .halogen: return "Halogene"
        case .lanthanide: return "Lanthanoide"
        case .actinide: return "Actinoide"
        case .unknown: return "Unbekannt"
        }
    }

    var color: Color {
        switch self {
        case .nonmetal:       return Color(red: 0xa3/255, green: 0xe4/255, blue: 0xa1/255)
        case .noblegas:       return Color(red: 0xff/255, green: 0xd1/255, blue: 0x66/255)
        case .alkali:         return Color(red: 0xff/255, green: 0x9a/255, blue: 0x76/255)
        case .alkaline:       return Color(red: 0xff/255, green: 0xba/255, blue: 0x6b/255)
        case .transition:     return Color(red: 0x9b/255, green: 0xd1/255, blue: 0xff/255)
        case .posttransition: return Color(red: 0xc9/255, green: 0xc9/255, blue: 0xe3/255)
        case .metalloid:      return Color(red: 0xdc/255, green: 0xd0/255, blue: 0x6f/255)
        case .halogen:        return Color(red: 0xff/255, green: 0xe0/255, blue: 0x66/255)
        case .lanthanide:     return Color(red: 0xf5/255, green: 0xa8/255, blue: 0xd8/255)
        case .actinide:       return Color(red: 0xf0/255, green: 0x8f/255, blue: 0xc4/255)
        case .unknown:        return Color(red: 0xbb/255, green: 0xbb/255, blue: 0xbb/255)
        }
    }

    var isLanthanideOrActinide: Bool {
        self == .lanthanide || self == .actinide
    }
}

struct Element: Identifiable, Hashable {
    let z: Int
    let symbol: String
    let col: Int
    let row: Int
    let category: ElementCategory
    let nameDE: String
    let nameFR: String
    let nameEN: String
    let nameLA: String
    let protons: Int
    let neutrons: Int
    let electrons: Int
    let mass: Double
    let meltingPointC: Double?
    let boilingPointC: Double?
    let stateAt20C: String
    let techApplications: [String]
    let compounds: [String]

    var id: Int { z }
}
