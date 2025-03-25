//
//  NavigationUtils.swift
//  Byala Blackspots App
//
//  Created by Ivan Myashkov on 23.12.19.
//  Copyright © 2019 Bitmap LTD. All rights reserved.
//

import Foundation

class NavigationUtils {
    
    static func prepareTopBar(navigationBar: UINavigationBar, title: String, backButton: UIBarButtonItem) {
            
        backButton.tintColor = UIColor.black
        
        let yourBackImage = UIImage(named: "icons8-back-50")
        backButton.image = yourBackImage
        
        let backItem: UINavigationItem = UINavigationItem(title: "")
        
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "ArialMT", size: 24)
        label.textAlignment = .center
        label.textColor = .black
        label.text = title
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        backItem.titleView = label
    
        backItem.leftBarButtonItem = backButton
        navigationBar.pushItem(backItem, animated: false)
        
        navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "ArialMT", size: 24)!]
    }
}
