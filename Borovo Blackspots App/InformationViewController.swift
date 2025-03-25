//
//  InformationViewController.swift
//  Byala Blackspots App
//
//  Created by Ivan Ugrin on W50/12/14/19.
//  Copyright © 2019 Bitmap LTD. All rights reserved.
//

import UIKit
import WebKit

class InformationViewController: UIViewController, WKNavigationDelegate, UIScrollViewDelegate {
    var fileName: String?
    
    var navBarTitle: String?
    
    @IBOutlet weak var mWebView: WKWebView!
    
    @IBOutlet weak var mNavigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //NavigationUtils.prepareTopBar(navigationBar: mNavigationBar, title: navBarTitle ?? "ИНФОРМАЦИЯ".localized, backButton: UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(back)))
        
        if
            let fileName = fileName,
            let pdf = Bundle.main.url(forResource: fileName, withExtension: "pdf") {
            let request = URLRequest(url: pdf)
            mWebView.load(request)
        }
        
        mWebView.backgroundColor = UIColor.white
        mWebView.navigationDelegate = self
        mWebView.scrollView.delegate = self
        
        for subView: UIView in mWebView.subviews {
            if (subView is UIScrollView) {
                for shadowView: UIView in subView.subviews {
                    if (shadowView is UIImageView) {
                        shadowView.isHidden = true
                        shadowView.removeFromSuperview()
                    }
                }
            }
        }
        
        Localizer.localizeChilds(view: view)
    }

     @objc func back() {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
        
        print("back clicked")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        hidePageNumberView(scrollView)
    }

    func hidePageNumberView(_ v: UIView) {
        for subView in v.subviews {
            if subView is UIImageView || subView is UILabel || subView is UIVisualEffectView {
                subView.isHidden = true
                subView.removeFromSuperview()

                if subView is UILabel {
                    if let sv = subView.superview {
                        sv.isHidden = true
                        sv.removeFromSuperview()
                    }
                }
            } else {
                hidePageNumberView(subView)
            }
        }
    }
    
    func getSubviewsOfView(v:UIView) -> [UIView] {
      var viewArray = [UIView]()
      for subview in v.subviews {
        viewArray += getSubviewsOfView(v: subview)
        viewArray.append(subview)
      }
      return viewArray
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      let webViewSubviews = self.getSubviewsOfView(v: self.mWebView)
      for v in webViewSubviews {
        if v.isKind(of: UILabel.self) || v.isKind(of: UIImageView.self) || v.isKind(of: UIVisualEffectView.self) {
          v.isHidden = true
          v.removeFromSuperview()
        }

        if v.description.range(of:"WKPDFPageNumberIndicator") != nil {
          v.isHidden = true // hide page indicator in upper left
          v.removeFromSuperview()
        }
      }
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
