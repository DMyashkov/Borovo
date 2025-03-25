//
//  AnnotationView.swift
//  pirin
//
//  Created by Ivan Ugrin on W27/07/04/19.
//  Copyright © 2019 Donatix. All rights reserved.
//

import UIKit

class AnnotationView: UIView {
    
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var ValueView1: UILabel!
    @IBOutlet weak var ContainerView1: UIView!
    
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var ValueView2: UILabel!
    @IBOutlet weak var ContainerView2: UIView!
    
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var ValueView3: UILabel!
    @IBOutlet weak var ContainerView3: UIView!
    
    @IBOutlet weak var Label4: UILabel!
    @IBOutlet weak var ValueView4: UILabel!
    @IBOutlet weak var ContainerView4: UIView!
    
    @IBOutlet weak var Label5: UILabel!
    @IBOutlet weak var ValueView5: UILabel!
    @IBOutlet weak var ContainerView5: UIView!
    
    @IBOutlet weak var Label6: UILabel!
    @IBOutlet weak var ValueView6: UILabel!
    @IBOutlet weak var ContainerView6: UIView!
    
    @IBOutlet weak var Label7: UILabel!
    @IBOutlet weak var ValueView7: UILabel!
    @IBOutlet weak var ContainerView7: UIView!
    
    @IBOutlet weak var Label8: UILabel!
    @IBOutlet weak var ValueView8: UILabel!
    @IBOutlet weak var ContainerView8: UIView!
    
    @IBOutlet weak var Label9: UILabel!
    @IBOutlet weak var ValueView9: UILabel!
    @IBOutlet weak var ContainerView9: UIView!
    
    @IBOutlet weak var Label10: UILabel!
    @IBOutlet weak var ValueView10: UILabel!
    @IBOutlet weak var ContainerView10: UIView!
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func setValues(poi: POIItem) -> Bool {
        
        var address: String?
        var details: String?
        var reason: String?
        
        let lang = UserDefaults.standard.string(forKey: "i18n_language")
        if(lang  == "bg") {
            address = poi.address
            details = poi.details
            reason = poi.reason
        } else if (lang == "en") {
            address = poi.addressEn
            details = poi.detailsEn
            reason = poi.reasonEn
        } else {
            address = poi.addressRo
            details = poi.detailsRo
            reason = poi.reasonRo
        }
        
        var hasData = false
        
        if poi.ident != nil {
            hasData = true
            Label1.text = "Идент".localized
            ValueView1.text = poi.ident
            
            ContainerView1.isHidden = false
        } else {
            ContainerView1.isHidden = true
        }
        
        if address != nil {
            hasData = true
            Label2.text = "Адрес".localized
            ValueView2.text = address
            
            ContainerView2.isHidden = false
        } else {
            ContainerView2.isHidden = true
        }
        
        if poi.participantsCount != nil {
            hasData = true
            Label3.text = "Брой участници".localized
            ValueView3.text = String(poi.participantsCount!)
            
            ContainerView3.isHidden = false
        } else {
            ContainerView3.isHidden = true
        }
        
        if poi.victimsCount != nil {
            hasData = true
            Label4.text = "Брой загинали".localized
            ValueView4.text = String(poi.victimsCount!)
            
            ContainerView4.isHidden = false
        } else {
            ContainerView4.isHidden = true
        }
        
        if poi.injuredCount != nil {
            hasData = true
            Label5.text = "Брой ранени".localized
            ValueView5.text = String(poi.injuredCount!)
            
            ContainerView5.isHidden = false
        } else {
            ContainerView5.isHidden = true
        }
        
        if details != nil {
            hasData = true
            Label6.text = "Описание".localized
            ValueView6.text = details
            
            ContainerView6.isHidden = false
        } else {
            ContainerView6.isHidden = true
        }
        
        if reason != nil {
            hasData = true
            Label7.text = "Причина".localized
            ValueView7.text = reason
            
            ContainerView7.isHidden = false
        } else {
            ContainerView7.isHidden = true
        }
        
        if poi.accident_particip1 != nil && poi.accident_particip1! > 0 {
            hasData = true
            Label8.text = "Участник 1".localized
            ValueView8.text = Parser.getParticipants()[poi.accident_particip1! - 1]
            
            ContainerView8.isHidden = false
        } else if poi.black_spot_Intensity != nil {
            hasData = true
            Label8.text = "Интензитет".localized
            ValueView8.text = String(poi.black_spot_Intensity!)
            
            ContainerView8.isHidden = false
        } else {
            ContainerView8.isHidden = true
        }
        
        if poi.accident_particip2 != nil && poi.accident_particip2! > 0 {
            hasData = true
            Label9.text = "Участник 2".localized
            ValueView9.text =  Parser.getParticipants()[poi.accident_particip2! - 1]
            
            ContainerView9.isHidden = false
        } else if poi.black_spot_StartDate != nil {
            hasData = true
            Label9.text = "Начало на период".localized
            ValueView9.text = String(poi.black_spot_StartDate!)
            
            ContainerView9.isHidden = false
        } else {
           ContainerView9.isHidden = true
        }
        
        if poi.accident_particip3 != nil && poi.accident_particip3! > 0 {
            hasData = true
            Label10.text = "Участник 3".localized
            ValueView10.text =  Parser.getParticipants()[poi.accident_particip3! - 1]
            
            ContainerView10.isHidden = false
        } else if poi.black_spot_EndDate != nil {
            hasData = true
            Label10.text = "Край на период".localized
            ValueView10.text = String(poi.black_spot_EndDate!)
            
            ContainerView10.isHidden = false
        } else {
            ContainerView10.isHidden = true
        }
        
        return hasData
    }

}
