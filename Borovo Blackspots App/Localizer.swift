//
//  Localizer.swift
//  Byala Blackspots App
//
//  Created by Ivan Myashkov on 26.12.19.
//  Copyright © 2019 Bitmap LTD. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        if let _ = UserDefaults.standard.string(forKey: "i18n_language") {} else {
            // we set a default, just in case
            UserDefaults.standard.set("bg", forKey: "i18n_language")
            UserDefaults.standard.synchronize()
        }

        let lang = UserDefaults.standard.string(forKey: "i18n_language")

        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)

        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

class Localizer {
    static func localizeChilds(view: UIView) {
        let webViewSubviews = getSubviewsOfView(v: view)
        for v in webViewSubviews {
            if v.isKind(of: UILabel.self) {
                let label = v as! UILabel
                label.text = label.text?.localized
            } else if v.isKind(of: UITextView.self) {
                let textView = v as! UITextView
                textView.text = textView.text?.localized
            } else if v.isKind(of: UITextField.self) {
                let textField = v as! UITextField
                textField.text = textField.text?.localized
                textField.placeholder = textField.placeholder?.localized
            } else if v.isKind(of: UIButton.self) {
                let button = v as! UIButton
                button.setTitle(button.currentTitle?.localized, for: .normal)
            }
        }
    }
    
    static func getSubviewsOfView(v:UIView) -> [UIView] {
      var viewArray = [UIView]()
      for subview in v.subviews {
        viewArray += getSubviewsOfView(v: subview)
        viewArray.append(subview)
      }
      return viewArray
    }
}
