//
//  ViewController.swift
//  SnapChatClone
//
//  Created by Joseph Cauley on 11/12/19.
//  Copyright © 2019 Joseph Cauley. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet var emailText: UITextField!
    @IBOutlet var userNameText: UITextField!
    @IBOutlet var passWordText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toTabBar", sender: nil)
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
    }
    

}

