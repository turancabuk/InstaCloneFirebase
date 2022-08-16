//
//  ViewController.swift
//  instaCloneFirebase
//
//  Created by Turan Çabuk on 16.08.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    
    
    
    
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
    
    
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        
        if emailText.text != nil{
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { data, error in
                
                if error != nil{
                    self.alert(titleInput: "error!", messageInput: "\(error?.localizedDescription)")
                    
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
    
    
    }
    func alert (titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}

