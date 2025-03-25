//
//  LocalisableLabel.swift
//  Borovo Blackspots App
//
//  Created by NIKOLAY VASILEV on 26.11.20.
//  Copyright © 2020 Bitmap LTD. All rights reserved.
//

import Foundation

class LocalisableLabel: UILabel {

    @IBInspectable var localisedKey: String? {
        didSet {
            guard let key = localisedKey else { return }
            //text = NSLocalizedString(key, comment: "")
            text = key.localized
        }
    }
}
