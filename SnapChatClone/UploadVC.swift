//
//  UploadVC.swift
//  SnapChatClone
//
//  Created by Joseph Cauley on 11/13/19.
//  Copyright © 2019 Joseph Cauley. All rights reserved.
//

import UIKit
import Firebase

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var uploadImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadImageView.isUserInteractionEnabled = true
        
        //gesture recognizer
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        uploadImageView.addGestureRecognizer(imageGestureRecognizer)
    }
    
    @objc func selectImage () {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = uploadImageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                
                if error != nil {
                    
                    self.userAlert(titleText: "Image Upload Error!", messageText: error?.localizedDescription ?? "Unknown Error")
                    
                } else {
                    
                    imageReference.downloadURL { (url, error) in
                        
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
                            let fireStore = Firestore.firestore()
                            
                            let snapDict = ["imageUrl" : imageUrl!, "snapOwner" : UserSingleton.SharedUserInfo.userName , "date" : FieldValue.serverTimestamp()] as [String : Any]
                            
                            fireStore.collection("Snaps").addDocument(data: snapDict) { (error) in
                                
                                if error != nil {
                                    
                                    self.userAlert(titleText: "Image Upload Error!", messageText: error?.localizedDescription ?? "Unknown Error")
                                    
                                } else {
                                    
                                    self.tabBarController?.selectedIndex = 0
                                    self.uploadImageView.image = UIImage(named: "selectImage")
                                }
                                
                            }
                            
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
