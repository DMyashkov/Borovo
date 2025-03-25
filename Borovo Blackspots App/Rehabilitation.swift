//
//  Rehabilitation.swift
//  Borovo Blackspots App
//
//  Created by NIKOLAY VASILEV on 27.11.20.
//  Copyright © 2020 Bitmap LTD. All rights reserved.
//

import Foundation

class Rehabilitation: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //NavigationUtils.prepareTopBar(navigationBar: mNavigationBar, title: "ИНФОРМАЦИЯ".localized, backButton: UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(back)))
        
        self.navigationItem.title = "УЧАСТЪЦИ ЗА РЕХАБИЛИТАЦИЯ".localized
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Назад".localized, style: .plain, target: nil, action: nil)
        
        Localizer.localizeChilds(view: view)
    }
}
