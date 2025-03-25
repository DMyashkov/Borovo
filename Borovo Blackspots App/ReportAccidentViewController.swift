//
//  ReportAccidentViewController.swift
//  Byala Blackspots App
//
//  Created by Ivan Myashkov on 18.12.19.
//  Copyright © 2019 Bitmap LTD. All rights reserved.
//

import UIKit
import MessageUI

class ReportAccidentViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var mCoordinate: CLLocationCoordinate2D?
    
    @IBOutlet weak var descriptionPicker: UISegmentedControl!
    @IBOutlet weak var countDeadTextField: UITextField!
    @IBOutlet weak var countInjuredTextField: UITextField!
    
    @IBOutlet weak var accidentImageView: UIImageView!
    
    @IBOutlet weak var mParticipant2TextView: UITextView!
    
    @IBOutlet weak var mNavigationItem: UINavigationItem!
    
    @IBOutlet weak var mReasonTextView: UITextView!
    
    @IBOutlet weak var mParticipant1TextView: UITextView!
    
    @IBOutlet weak var mParticipant3TextView: UITextView!
    
    let imagePicker = UIImagePickerController()
    
    private static let EMPTY_SELECTION = "-"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Localizer.localizeChilds(view: view)

        
        mNavigationItem.title = "Нов инцидент".localized
    }
    
    @IBAction func onParticipant3Tap(_ sender: Any) {
        showChooser(title: "Избери участник".localized, values: Parser.getParticipants(), resultView: mParticipant3TextView)
    }
    
    @IBAction func onParticipant1Tap(_ sender: Any) {
        showChooser(title: "Избери участник".localized, values: Parser.getParticipants(), resultView: mParticipant1TextView)
    }
    
    @IBAction func onReasonTap(_ sender: Any) {
        showChooser(title: "Избери причина".localized, values: Parser.getReasons(), resultView: mReasonTextView)
    }
    
    @IBAction func onParciticapnt2Tap(_ sender: Any) {
        showChooser(title: "Избери участник".localized, values: Parser.getParticipants(), resultView: mParticipant2TextView)
    }
    
    func showChooser(title: String, values: [String], resultView: UITextView) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        

        for value in values {
            let participantAction = UIAlertAction(title: value, style: .default){
                UIAlertAction in
                resultView.text = value
            }

            alert.addAction(participantAction)
        }
        
        let cancelAction = UIAlertAction(title: "Отказ".localized, style: .cancel){
            UIAlertAction in
            resultView.text = ReportAccidentViewController.EMPTY_SELECTION
        }
        
        alert.addAction(cancelAction)
        
        alert.popoverPresentationController?.sourceView = self.view
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onPickImageClicked(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
            self.accidentImageView.image = image
           }
    }
    
    @IBAction func onSendClicked(_ sender: Any) {
        
        let selectedReason  = getValueFromTextField(textView: mReasonTextView)
        
        let participant1 = getValueFromTextField(textView: mParticipant3TextView)
        
        let participant3 = getValueFromTextField(textView: mParticipant3TextView)
        
        let description = descriptionPicker.titleForSegment(at: descriptionPicker.selectedSegmentIndex)
        let deadCount = countDeadTextField.text
        let injuredCount = countInjuredTextField.text
    
        let participant2 = getValueFromTextField(textView: mParticipant2TextView)

        let emailTitle = "Add accident"
        let messageBody = "Lat: \(mCoordinate?.latitude ?? 0.0)\n" +
            "Long: \(mCoordinate?.longitude ?? 0.0)\n" +
            "Deaths count: \(deadCount ?? "")\n" +
            "Injured count: \(injuredCount ?? "")\n" +
            "Details: \(description ?? "")\n" +
            "Reason: \(selectedReason)\n" +
            "Participant 1: \(participant1)\n" +
            "Participant 2: \(participant2)\n" +
            "Participant 3: \(participant3)\n"
        
        let toRecipents = ["blackspots@bitmap-bulgaria.com"]

        if (MFMailComposeViewController.canSendMail()) {
            let mc = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject(emailTitle)
            mc.setMessageBody(messageBody, isHTML: false)
            mc.setToRecipients(toRecipents)
            
            if accidentImageView.image != nil {
                let imageData: NSData = accidentImageView.image!.pngData()! as NSData
                mc.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "imageName.png")
            }
            
            self.present(mc, animated: true, completion: nil)
        }
    }
    
    func getValueFromTextField(textView: UITextView) -> String {
        if textView.text == nil || textView.text?.isEmpty ?? true {
            return ReportAccidentViewController.EMPTY_SELECTION
        } else {
            return textView.text!
        }
    }
    
    func setCoordinates(coordinate: CLLocationCoordinate2D) {
        mCoordinate = coordinate
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: false, completion: nil)
        dismiss(animated: true, completion: nil)
    }
}
