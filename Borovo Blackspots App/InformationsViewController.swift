//
//  InformationsViewController.swift
//  Byala Blackspots App
//
//  Created by Ivan Myashkov on 13.12.19.
//  Copyright © 2019 Bitmap LTD. All rights reserved.
//

import UIKit
import Lightbox

class InformationsViewController: UIViewController {
    

    @IBOutlet weak var mNavigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //NavigationUtils.prepareTopBar(navigationBar: mNavigationBar, title: "ИНФОРМАЦИЯ".localized, backButton: UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(back)))
        
        self.navigationItem.title = "ИНФОРМАЦИЯ".localized
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Назад".localized, style: .plain, target: nil, action: nil)
        
        Localizer.localizeChilds(view: view)
    }
    
    
    
     @objc func back() {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
        
        print("back clicked")
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if
            segue.identifier == "ShowInfo",
            let vc = segue.destination as? InformationViewController {
            
            let infoDoc = sender as! InfoDoc
            vc.fileName = infoDoc.fileName
            vc.navBarTitle = infoDoc.title
        }
    }
    
    @IBAction func onReconstruction(_ sender: Any) {
        //performSegue(withIdentifier: "ShowInfo", sender: InfoDoc(fileName: "reconstriction_needed_places".localized, title: "УЧАСТЪЦИ ЗА РЕХАБИЛИТАЦИЯ".localized))
    }
    @IBAction func onForTheApp(_ sender: Any) {
        //performSegue(withIdentifier: "ShowInfo", sender: InfoDoc(fileName: "for_app".localized, title: "ЗА ПРИЛОЖЕНИЕТО".localized))
    }
    @IBAction func onForTheProject(_ sender: Any) {
        //performSegue(withIdentifier: "ShowInfo", sender: InfoDoc(fileName: "for_project".localized, title: "ЗА ПРОЕКТА".localized))
    }
    @IBAction func onByalaMuniplicity(_ sender: Any) {
        //performSegue(withIdentifier: "ShowInfo", sender: InfoDoc(fileName: "mmunicipality".localized, title: "ОБЩИНА БЯЛА".localized))
    }
    @IBAction func onImportantObjects(_ sender: Any) {
        //performSegue(withIdentifier: "ShowInfo", sender: InfoDoc(fileName: "important_objects".localized, title: "ВАЖНИ ОБЕКТИ".localized))
    }
    @IBAction func onGallerySelected(_ sender: Any) {
        let images = [
            LightboxImage(
              image: UIImage(named: "photo1")!,
              text: ""
            ),
            LightboxImage(
              image: UIImage(named: "photo2")!,
              text: ""
            ),
            LightboxImage(
              image: UIImage(named: "photo3")!,
              text: ""
            ),
            LightboxImage(
              image: UIImage(named: "photo4")!,
              text: ""
            ),
            LightboxImage(
              image: UIImage(named: "photo5")!,
              text: ""
            ),
            LightboxImage(
              image: UIImage(named: "photo6")!,
              text: ""
            ),
            LightboxImage(
              image: UIImage(named: "photo7")!,
              text: ""
            )
        ]
        
        // Create an instance of LightboxController.
        let controller = LightboxController(images: images, startIndex: 0)
        controller.modalPresentationStyle = .fullScreen

        // Use dynamic background.
        controller.dynamicBackground = true

        // Present your controller.
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onRouteRules(_ sender: Any) {
        //performSegue(withIdentifier: "ShowInfo", sender: InfoDoc(fileName: "safety_instructions".localized, title: "ПРАВИЛА ЗА ПЪТНА БЕЗОПАСНОСТ".localized))
    }
}
