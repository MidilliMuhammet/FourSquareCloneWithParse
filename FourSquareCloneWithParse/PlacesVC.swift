//
//  PlacesVC.swift
//  FourSquareCloneWithParse
//
//  Created by Muhammet Midilli on 15.03.2021.
//

import UIKit
import Parse

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var placeNameArray = [String]()
    var placeIdArray = [String]()
    var selectedPlaceId = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        //adding add button
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        //adding logout button
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
        
        //delegation
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    
    //get data from parse
    func getData() {
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAlert(messageInput: error?.localizedDescription ?? "Error!")
            } else {
                if objects != nil {
                    self.placeNameArray.removeAll(keepingCapacity: false)
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String {
                            if let placeId = object.objectId {
                                self.placeNameArray.append(placeName)
                                self.placeIdArray.append(placeId)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //for detailsVC segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.chosenPlaceId = selectedPlaceId
        }
    }
    
    //for detailsVC segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = placeIdArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
    }
    
    @objc func addButtonClicked() {
        //segue
        self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
    }
    
    @objc func logoutButtonClicked() {
        //logout func
        PFUser.logOutInBackground { (error) in
            if error != nil {
                self.makeAlert(messageInput: error?.localizedDescription ?? "Error!")
            } else {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
    }
    
    //alert func
    func makeAlert(messageInput : String) {
        let alert = UIAlertController(title: "ERROR", message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
