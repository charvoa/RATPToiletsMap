//
//  ToiletteModel.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 10/02/2024.
//

import Foundation
import CoreLocation

enum ToiletteType: String, CaseIterableDefaultsLast, Codable {
    case sanisette = "SANISETTE"
    case toilettes = "TOILETTES"
    case wcPublic = "WC PUBLICS PERMANENTS"
    case other
}

enum DisplayHoraire {
    case open247
    case noInfo
    case availableOnEquipment
    case times(opening: Date, closing: Date)

    func value(withLocale locale: Locale = Locale.current) -> String {
        switch self {
        case .open247:
            return "Ouvert 24h/24"
        case .noInfo:
            return "Détail des horaires indisponible"
        case .availableOnEquipment:
            return "Détail des horaires disponibles sur place"
        case .times(let opening, let closing):
            return String(format: "Ouvert de %@ à %@", DateFormatter.shortFormatter(withLocale: locale).string(from: opening), DateFormatter.shortFormatter(withLocale: locale).string(from: closing))
        }
    }
}

struct ToiletteModelNetwork: Decodable {
    var complementAdresse: String?
    var geoPoint2d: [Double]
    var accesPmr: String?
    var horaire: String?
    var gestionnaire: String?
    var adresse: String?
    var type: ToiletteType
    var relaisBebe: String?

    enum CodingKeys: String, CodingKey {
        case complementAdresse = "complement_adresse"
        case geoPoint2d = "geo_point_2d"
        case accesPmr = "acces_pmr"
        case relaisBebe = "relais_bebe"

        case horaire, gestionnaire, adresse, type
    }
}

struct ToiletteModel: Identifiable {
    let id: UUID
    private let complementAdresse: String?
    private let geoPoint2d: [Double]
    private let accesPmr: String?
    private let horaire: String?
    private let gestionnaire: String?
    private let adresse: String?
    private let type: ToiletteType
    private let relaisBebe: String?

    init(from networkModel: ToiletteModelNetwork) {
        self.id = UUID()
        self.complementAdresse = networkModel.complementAdresse
        self.geoPoint2d = networkModel.geoPoint2d
        self.accesPmr = networkModel.accesPmr
        self.horaire = networkModel.horaire
        self.gestionnaire = networkModel.gestionnaire
        self.adresse = networkModel.adresse
        self.type = networkModel.type
        self.relaisBebe = networkModel.relaisBebe
    }

    var title: String {
        return adresse ?? "N/A"
    }

    var subtitle: String {
        return gestionnaire ?? "N/A"
    }

    var hasPmrAccess: Bool {
        return accesPmr?.caseInsensitiveCompare("oui") == .orderedSame
    }

    var hasBabyRelay: Bool {
        return relaisBebe?.caseInsensitiveCompare("oui") == .orderedSame
    }

    var addressComplement: String? {
        guard complementAdresse?.caseInsensitiveCompare("numero_de_voie nom_de_voie") == .orderedSame else {
            return nil
        }

        return complementAdresse
    }

    var coordinates: CLLocationCoordinate2D? {
        guard let latitude = geoPoint2d.first, let longitude = geoPoint2d.last else { return nil }

        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    private var openingTime: Date? {
        guard let horaire else { return nil }

        let hours = horaire.components(separatedBy: CharacterSet.decimalDigits.inverted).filter { !$0.isEmpty }

        var hour = 0
        var minute = 0

        if hours.count == 2 {
            hour = Int(hours[0]) ?? 0
        } else if hours.count == 4 {
            hour = Int(hours[0]) ?? 0
            minute = Int(hours[1]) ?? 0
        } else {
            return nil
        }

        return Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())
    }

    private var closingTime: Date? {
        guard let horaire else { return nil }

        let hours = horaire.components(separatedBy: CharacterSet.decimalDigits.inverted).filter { !$0.isEmpty }

        var hour = 0
        var minute = 0

        if hours.count == 2 {
            hour = Int(hours[1]) ?? 0
        } else if hours.count == 4 {
            hour = Int(hours[2]) ?? 0
            minute = Int(hours[3]) ?? 0
        } else {
            return nil
        }

        guard let closingDate = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date()) else {
            return nil
        }

        if hour < Calendar.current.component(.hour, from: openingTime ?? Date()) {
            return Calendar.current.date(byAdding: .day, value: 1, to: closingDate)
        } else {
            return closingDate
        }
    }

    var displayHoraire: DisplayHoraire {
        guard let horaire else {
            return .noInfo
        }

        if horaire.caseInsensitiveCompare("24 h / 24") == .orderedSame {
            return .open247
        }

        if horaire.caseInsensitiveCompare("Voir fiche équipement") == .orderedSame {
            return .availableOnEquipment
        }

        guard let openingTime,
              let closingTime else {
            return .noInfo
        }

        return .times(opening: openingTime, closing: closingTime)
    }

    var isOpen: Bool? {
        if case .open247 = displayHoraire { return true }

        guard let openingTime, let closingTime else { return nil }
        
        let currentDate = Date()

        return openingTime < currentDate && closingTime > currentDate
    }
}
