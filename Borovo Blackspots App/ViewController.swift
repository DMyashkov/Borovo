//
//  ViewController.swift
//  Byala Blackspots App
//
//  Created by Ivan Myashkov on 12.12.19.
//  Copyright © 2019 Bitmap LTD. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON
import AVFoundation

extension ViewController: GMUClusterRendererDelegate {
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        // if your marker is pointy you can change groundAnchor
        marker.groundAnchor = CGPoint(x: 0.5, y: 1)
        if  let markerData = (marker.userData as? POIItem) {
            let imageName = Parser.getIconName(id: markerData.accident_icon)
            
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            marker.icon = image
            marker.iconView = imageView
        }
    }
}

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var vieww: UIView!
    @IBOutlet weak var mMapView: GMSMapView!
    
    @IBOutlet weak var mMapBackButton: UIButton!
    
    var clusterManager: GMUClusterManager?

    var locationManager = CLLocationManager()

    var player: AVAudioPlayer?
    
    var mBlackSpots: [CLLocationCoordinate2D] = []
    
    var mIsUpdatingLocation = false
    
    var mBounds: GMSCoordinateBounds?
    
    @IBOutlet weak var mTopViewImage: UIImageView!
    
    @IBOutlet weak var mNewAccidentLabel: UILabel!
    @IBOutlet weak var mFollowingLabel: UILabel!
    @IBOutlet weak var mInformationLabel: UILabel!
    
    @IBOutlet weak var mLongPressToReportTextLabel: UILabel!
    @IBOutlet weak var mLongPressToReportLabel: UIView!
    
    var mLastTimeSoundPlayed: Double = 0.0
    
    @IBOutlet weak var mLocateMeButton: UIButton!
    @IBOutlet weak var mFullMapButton: UIButton!
    
    lazy var mMapExpandedConstraint: NSLayoutConstraint = {
        let margins = view.layoutMarginsGuide
        return mMapView.topAnchor.constraint(equalTo: margins.topAnchor)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //
        //vieww.layer.cornerRadius = vieww.frame.height/2
        //vieww.layer.masksToBounds = true
        //
        
        self.mLocateMeButton.isHidden = false
        
        Networking.shared.accidents { ( response) in
            if let response = response {
                self.onGeoJsonReceived(response: response)
            }
        }
        
        Networking.shared.blackspots { ( response) in
            if let response = response {
                self.onGeoJsonReceived(response: response)
            }
        }
        
        mMapView.delegate = self
        
        mMapView.isTrafficEnabled = true
        mMapView?.isMyLocationEnabled = true

         //Location Manager code to fetch current location
         self.locationManager.delegate = self
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Назад".localized, style: .plain, target: nil, action: nil)
        
        Localizer.localizeChilds(view: view)
    }
    
    @IBAction func onSelectLanguage(_ sender: Any) {

        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let bulgarianAction = UIAlertAction(title: "Български", style: .default){
            UIAlertAction in
            
            self.changeLaunguage(languageCode: "bg")
        }
        
        let englishAction = UIAlertAction(title: "English", style: .default){
            UIAlertAction in
            
            self.changeLaunguage(languageCode: "en")
        }
        
        let romanianAction = UIAlertAction(title: "Română", style: .default){
            UIAlertAction in
            
            self.changeLaunguage(languageCode: "ro")
        }
        
        let cancelAction = UIAlertAction(title: "Отказ".localized, style: .cancel){
            UIAlertAction in
        }

        alert.addAction(bulgarianAction)
        alert.addAction(englishAction)
        alert.addAction(romanianAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.view
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeLaunguage(languageCode: String) {
        UserDefaults.standard.set(languageCode, forKey: "i18n_language")
        mNewAccidentLabel.text = "НОВ ИНЦИДЕНТ".localized
        mFollowingLabel.text = "СЛЕДВАНЕ".localized
        mInformationLabel.text = "ИНФОРМАЦИЯ".localized
        mLongPressToReportTextLabel.text = "Задръжте пръст върху картата, за да докладвате за инцидент".localized
        
        clusterManager?.cluster()
        
        Localizer.localizeChilds(view: self.view!)
    }
    
    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locations.last

        mMapView.animate(to:  GMSCameraPosition.camera(withTarget: location!.coordinate, zoom: 17.0))

        let currentTime = CACurrentMediaTime();
        if location != nil && currentTime - mLastTimeSoundPlayed > 10 {
            
            for coordinates in mBlackSpots {
                if location!.distance(from: CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) < CLLocationDistance(500.00) {
                    mLastTimeSoundPlayed = CACurrentMediaTime();
                    playSound()
                    break
                }
            }
        }

    }
    
    @IBAction func onMapFullScreen(_ sender: Any) {
        expandMap()
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ReportAccidentViewController")
         if let controller = controller as? ReportAccidentViewController {
            controller.setCoordinates(coordinate: coordinate)
         }
        self.present(controller, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let annotationView = AnnotationView.fromNib() as AnnotationView
        
        if  let markerData = (marker.userData as? POIItem) {
            if annotationView.setValues(poi: markerData) {
                return annotationView
            }
        }
        
        return nil
    }
    
    func setupClusterManager() {
        
        if clusterManager == nil {
            let iconGenerator = GMUDefaultClusterIconGenerator()
            let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
            let renderer = GMUDefaultClusterRenderer(mapView: mMapView,
                                        clusterIconGenerator: iconGenerator)
            renderer.delegate = self
            clusterManager = GMUClusterManager(map: mMapView, algorithm: algorithm, renderer: renderer)
        }
    }
    
    func onGeoJsonReceived(response: JSON){
        setupClusterManager()
        do{
            let rawData = try response.rawData()
            let geoJsonParser = GMUGeoJSONParser(data: rawData)
            geoJsonParser.parse()
            
            let stringFeatures = response.dictionaryObject?["features"] as! [[String: Any]]
            
            if mBounds == nil {
                mBounds = GMSCoordinateBounds()
            }
            
            for feature in stringFeatures {

                let coordinates = Parser.featureJsonToCoordinates(feature: feature)!
                
                mBounds = mBounds!.includingCoordinate(coordinates)
                
                let item = POIItem(position: coordinates, name: feature.description, properties: (feature["properties"] as! [String: Any]))
                
                if item.accident_icon == nil {
                    mBlackSpots.append(coordinates)
                }
                
                clusterManager?.add(item)
            }

            clusterManager?.cluster()
            mMapView.animate(with: GMSCameraUpdate.fit(mBounds!))
        } catch {
            
        }
    }
    
    @IBAction func followTapRecognizer(_ sender: Any) {
        mIsUpdatingLocation = true
        self.locationManager.startUpdatingLocation()
        
        expandMap()
    }
    
    @IBAction func mNewActionTapRecognizer(_ sender: Any) {
        returnToBlackSpots()
        
        expandMap()
    }
    
    func returnToBlackSpots() {
        mIsUpdatingLocation = false
        self.locationManager.stopUpdatingLocation()
        
        if mBounds != nil {
            mMapView.animate(with: GMSCameraUpdate.fit(mBounds!))
        }
    }
    
    @IBAction func onMapHideClicked(_ sender: Any) {
        returnToBlackSpots()

        self.mMapBackButton.isHidden = true
        //self.mLocateMeButton.isHidden = false
        self.mLongPressToReportLabel.isHidden = true
        
        self.view.layoutIfNeeded()
        
        mMapExpandedConstraint.isActive = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }) { (result) in
           //self.mFullMapButton.isHidden = false
       }
    }
    
    @IBAction func onLocateMe(_ sender: Any) {
        if mIsUpdatingLocation {
            self.locationManager.stopUpdatingLocation()
            returnToBlackSpots()
        } else {
             self.locationManager.startUpdatingLocation()
        }

        mIsUpdatingLocation = !mIsUpdatingLocation
    }
    
    func expandMap() {
        self.view.layoutIfNeeded()
        
        mMapExpandedConstraint.isActive = true

        //mFullMapButton.isHidden = true
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }) { (result) in
            self.mMapBackButton.isHidden = false
            self.mLocateMeButton.isHidden = false
            self.mLongPressToReportLabel.isHidden = false
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "nearby_black_spot", withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

