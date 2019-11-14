//
//  FeedVC.swift
//  SnapChatClone
//
//  Created by Joseph Cauley on 11/13/19.
//  Copyright © 2019 Joseph Cauley. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController {
    
    @IBOutlet var feedTableView: UITableView!
    
    let fireStoreDB = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        getUserInfo()
    }

    func getUserInfo() {
        
        fireStoreDB.collection("userInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
            if error != nil {
                self.userAlert(titleText: "Error", messageText: error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        if let username = document.get("username") as? String {
                            UserSingleton.SharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.SharedUserInfo.userName = username
                        }
                    }
                }
            }
        }
    }
    
    func userAlert (titleText : String, messageText : String) {
        
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }

}
