//
//  Parser.swift
//  Byala Blackspots App
//
//  Created by Ivan Myashkov on 16.12.19.
//  Copyright © 2019 Bitmap LTD. All rights reserved.
//

import Foundation


class Parser {
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func featureJsonToCoordinates(feature: [String: Any]) -> CLLocationCoordinate2D? {
        let geometry = feature["geometry"] as! [String: Any]
        
        
        guard let coordinates = geometry["coordinates"] as? [NSNumber] else {
            let coordinates = geometry["coordinates"] as? [[NSNumber]]

            return CLLocationCoordinate2DMake(CLLocationDegrees(truncating: coordinates?[0][1] ?? 0), CLLocationDegrees(truncating: coordinates?[0][0] ?? 0))
        }

        return CLLocationCoordinate2DMake(CLLocationDegrees(truncating: coordinates[1]), CLLocationDegrees(truncating: coordinates[0]))
    }
    
    static func getIconName(id: Int?) -> String {
        switch id {
            case 1: return "ic_accident_1.png"
            case 2: return "ic_accident_2.png"
            case 3: return "ic_accident_3.png"
            case 4: return "ic_accident_4.png"
            case 5: return "ic_accident_5.png"
            case 6: return "ic_accident_6.png"
            case 11: return "ic_accident_11.png"
            default: return "ic_blackspot.png"
        }
    }
    
    static func getParticipants() -> [String] {
        return [
            "Автомобил".localized,
            "Мотоциклет".localized,
            "Пешеходец".localized,
            "Камион".localized,
            "Друго".localized
        ]
    }
    
    static func getReasons() -> [String] {
        return  [
            "Загубване на контрол при управление на МПС".localized,
            "Неспазване на предимство на кръстовище".localized,
            "Неправилно разминаване".localized,
            "Неправилно завиване".localized,
            "Неправилно движение на заден ход".localized,
            "Движение с несъобразена скорост".localized,
            "Потегляне на спряло (паркирано) превозно средство без шофьор".localized,
            "Движение на технически неизправно МПС".localized,
            "Неправилно завиване в обратна посока".localized,
            "Неправилно изпреварване".localized,
            "Неспазване на знаци и светлинни сигнали".localized,
            "Не направляване на ППС с животинска тяга".localized,
            "Неспазване на дистанция".localized,
            "Неправилни маневри".localized
        ]
    }
}
