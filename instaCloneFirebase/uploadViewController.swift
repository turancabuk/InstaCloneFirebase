//
//  uploadViewController.swift
//  instaCloneFirebase
//
//  Created by Turan Çabuk on 17.08.2022.
//

import UIKit
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth




class uploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    
    @IBOutlet weak var commentTextfield: UITextField!
    @IBOutlet weak var dateTextfield: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectPhoto))
        imageView.addGestureRecognizer(gestureRecognizer)
    
        
    
    
   
        
    }
    @objc func selectPhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    func makeAlert (titleInput : String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString

            let imageReference = mediaFolder.child("\(uuid).jpeg")
            imageReference.putData(data, metadata: nil) { metaData, error in
                
                if error != nil{
                    self.makeAlert(titleInput: "error!", messageInput: "\(error?.localizedDescription ?? "error")")
                }else{
                    imageReference.downloadURL { url, error in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            
                            
                            //DATABASE.
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email, "postComment" : self.commentTextfield.text!,"date" : FieldValue.serverTimestamp(), "likes" : 0 ] as [String : Any]
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil{
                                    self.makeAlert(titleInput: "error!", messageInput: error?.localizedDescription ?? "error")
                                }else{
                                    self.imageView.image = UIImage(named: "select.png")
                                    self.commentTextfield.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                        
                    }
                }
            }
        }
    }
    
    

}
