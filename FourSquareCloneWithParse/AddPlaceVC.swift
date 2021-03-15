//
//  AddPlaceVC.swift
//  FourSquareCloneWithParse
//
//  Created by Muhammet Midilli on 15.03.2021.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeAtmosphereText: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageview codes
        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
        //hiding keyboard when tap vc except for keyboard
        let hidingGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hidingGestureRecognizer)
      
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if placeNameText.text == "" {
            self.makeAlert(messageInput: "Fill the place name area")
        } else if placeTypeText.text == "" {
            self.makeAlert(messageInput: "Fill the place type area")
        } else if placeAtmosphereText.text == "" {
            self.makeAlert(messageInput: "Fill the place atmosphere area")
        } else {
            let placeModel = PlaceModel.sharedInstance
            placeModel.placeName = placeNameText.text!
            placeModel.placeType = placeTypeText.text!
            placeModel.placeAtmosphere = placeAtmosphereText.text!
            let choosenImage = placeImageView.image
            placeModel.placeImage = choosenImage!
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
        }
    }
    
    //hiding keyboard objc fun
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    //image picker func
    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    //to close picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        nextButtonOutlet.isEnabled = true
    }
    
    //alert func
    func makeAlert(messageInput : String) {
        let alert = UIAlertController(title: "ERROR", message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
