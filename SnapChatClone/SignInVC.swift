//
//  ViewController.swift
//  SnapChatClone
//
//  Created by Joseph Cauley on 11/12/19.
//  Copyright © 2019 Joseph Cauley. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet var emailText: UITextField!
    @IBOutlet var userNameText: UITextField!
    @IBOutlet var passWordText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gesture recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func dismissKeyboard () {
        
        view.endEditing(true)
        
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
        if emailText.text! != "" && passWordText.text! != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passWordText.text!) { (result, error) in
                
                if error != nil {
                    
                    self.userAlert(titleText: "Sign In Error!", messageText: error?.localizedDescription ?? "Unknown Error")
                    
                } else {
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                }
            
                self.userAlert(titleText: "Sign In Error!", messageText: "Enter email and password to sign in!")
    
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if emailText.text! != "" && userNameText.text! != "" && passWordText.text! != "" {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passWordText.text!) { (auth, error) in
                
                if error != nil {
                    
                    self.userAlert(titleText: "Create User Error!", messageText: error?.localizedDescription ?? "Unknown Error")
                    
                } else {
                    
                    let fireStore = Firestore.firestore()
                    
                    let userDict = ["email" : self.emailText.text!, "userName" : self.userNameText.text!] as [String : Any]
                    
                    fireStore.collection("userInfo").addDocument(data: userDict) { (error) in
                        
                        if error != nil {
                            
                            self.userAlert(titleText: "Create User Error!", messageText: error?.localizedDescription ?? "Unknown Error")
                            
                        }
                        
                    }
                    
                    
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                }
            }
            
        } else {
            
            self.userAlert(titleText: "Create User Error!", messageText: "Enter email, user name and password to sign up!")
            
        }
        
    }
    
    func userAlert (titleText : String, messageText : String) {
        
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
}

