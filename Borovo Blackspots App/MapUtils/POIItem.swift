//
//  POIItem.swift
//  Byala Blackspots App
//
//  Created by Ivan Myashkov on 15.12.19.
//  Copyright © 2019 Bitmap LTD. All rights reserved.
//

import Foundation

class POIItem: NSObject, GMUClusterItem {
  var position: CLLocationCoordinate2D
  var name: String!
    
    // ACCIDENTS only
    var accident_participentsC: String? // "particip_c":"4",
    var accident_participantType: String? // "particip_t":"камион",
    var accident_particip1: Int? // "particip1":4,
    var accident_particip2: Int?  // "particip2":0,
    var accident_particip3: Int?  // "particip3":0,
    var accident_icon: Int? // "icon":4,
    
    // shared
    var victimsCount: Int? // "victims_n":0,
    var address: String? // "address":"гр. Бяла ул. К. Фичето 17",
    var addressEn: String?
    var participantsCount: Int? // "particip_n":1,
    var injuredCount: Int? // "injured":0,
    var noteCode: String? // "note_code":"МЩ",
    var details: String? // "note_text":"материални щети",
    var detailsEn: String?
    var reasonCode: Int? // "reason_c":3,
    var reason: String? // "reason_t":"неправилно движение на заден ход",
    var speed: Int? // "speed":90
    var municipality: String? // "mun":"BYA",
    var ident: String? // "ident":"31_BG_BYA_2014-09-24",
    var date: String? // "date":"2014-09-23Z",
    var country: String? // "country":"BG",
    
    var reasonEn: String?
    var reasonRo: String?
    var addressRo: String?
    var detailsRo: String?

    // Blackspots only
    var black_spot_Intensity: Int? // "intensity":56,
    var black_spot_StartDate: String? // "data_b":"2013-12-31T22:00:00Z",
    var black_spot_EndDate: String? // "data_e":"2019-09-30T21:00:00Z",

  init(position: CLLocationCoordinate2D, name: String, properties: [String: Any]?) {
    self.position = position
    self.name = name
  
    accident_participentsC = properties!["particip_c"] as! String?
     accident_participantType = properties!["particip_t"] as! String? // ":"камион",
     accident_particip1 = properties!["particip1"] as! Int? // "particip1":4,
     accident_particip2 = properties!["particip2"] as! Int?  // "particip2":0,
     accident_particip3 = properties!["particip3"] as! Int?  // "particip3":0,
     accident_icon = properties!["icon"] as!  Int? // "icon":4,
     
     // shared
    victimsCount = properties!["victims_n"] as! Int? // "victims_n":0,
     address = properties!["address"] as! String? // "address":"гр. Бяла ул. К. Фичето 17"
    participantsCount = properties!["particip_n"] as! Int? // "particip_n":1,
     injuredCount = properties!["injured"] as! Int? // "injured":0,
     noteCode = properties!["note_code"] as! String? // "note_code":"МЩ",
     details = properties!["note_text"] as! String? // "note_text":"материални щети",
     reasonCode = properties!["reason_c"] as! Int? // "reason_c":3,
     reason = properties!["reason_t"] as! String? // "reason_t":"неправилно движение на заден ход",
     speed = properties!["speed"] as! Int? // "speed":90
     municipality = properties!["mun"] as! String? // "mun":"BYA",
     ident = properties!["ident"] as! String? // "ident":"31_BG_BYA_2014-09-24",
     date = properties!["date"] as! String? // "date":"2014-09-23Z",
     country = properties!["country"] as! String? // "country":"BG",

    detailsEn = properties!["note_text_en"] as! String?
    addressEn = properties!["address_en"] as! String?
    reasonEn = properties!["reason_t_en"] as! String?

    detailsRo = properties!["note_text_ro"] as! String?
    addressRo = properties!["address_ro"] as! String?
    reasonRo = properties!["reason_t_ro"] as! String?
    

     // Blackspots only
     black_spot_Intensity = properties!["intensity"] as! Int? // "intensity":56,
     black_spot_StartDate = properties!["data_b"] as! String? // "data_b":"2013-12-31T22:00:00Z",
     black_spot_EndDate = properties!["data_e"] as! String? // "data_e":"2019-09-30T21:00:00Z",
  }
}
