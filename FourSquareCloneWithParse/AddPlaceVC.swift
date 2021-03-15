//
//  AddPlaceVC.swift
//  FourSquareCloneWithParse
//
//  Created by Muhammet Midilli on 15.03.2021.
//

import UIKit

class AddPlaceVC: UIViewController {

    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeAtmosphereText: UITextField!
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toMapVC", sender: nil)
        
    }
    

}
