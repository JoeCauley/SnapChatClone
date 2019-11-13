//
//  SettingsVC.swift
//  SnapChatClone
//
//  Created by Joseph Cauley on 11/13/19.
//  Copyright © 2019 Joseph Cauley. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toDignInVC", sender: nil)
        
    }
    
   
}
