//
//  SettingsVC.swift
//  SnapChatClone
//
//  Created by Joseph Cauley on 11/13/19.
//  Copyright © 2019 Joseph Cauley. All rights reserved.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        
        do {
            
            try Auth.auth().signOut()
            
        } catch {
            
            let alert = UIAlertController(title: "Sign Out Error!", message: "Unknown Error", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true)
            
        }
        
        performSegue(withIdentifier: "toSIgnInVC", sender: nil)
        
    }
    
   
}
