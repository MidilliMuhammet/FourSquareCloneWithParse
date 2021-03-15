//
//  MapVC.swift
//  FourSquareCloneWithParse
//
//  Created by Muhammet Midilli on 15.03.2021.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adding save button
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        //adding back button
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
    }
    
    //save button func
    @objc func saveButtonClicked() {
        //Parse
    }
    
    @objc func backButtonClicked() {
        //to back code
        self.dismiss(animated: true, completion: nil)
    }

    

}
