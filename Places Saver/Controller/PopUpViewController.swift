//
//  PopUpViewController.swift
//  Places Saver
//
//  Created by Mohamed Elkomey on 11/07/2023.
//

import UIKit
import RealmSwift

class PopUpViewController: UIViewController {

    var realm = try! Realm()
    
    @IBOutlet weak var placeNameTxtField: UITextField!
    @IBOutlet weak var descreptionTxtView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        dismiss(animated: true)
        let newLandmark = Landmark()
        newLandmark.name = placeNameTxtField.text!
        newLandmark.descreption = descreptionTxtView.text!
        newLandmark.longitude = Places.shared.userLangitude
        newLandmark.Latitude = Places.shared.userLatitude
        
        try! realm.write{
            realm.add(newLandmark)
        }
        
        
       // Places.shared.landmarks.append(newLandmark)
    }
    
}
