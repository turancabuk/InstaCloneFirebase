//
//  settingsViewController.swift
//  instaCloneFirebase
//
//  Created by Turan Çabuk on 16.08.2022.
//

import UIKit
import Firebase

class settingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutClicked(_ sender: Any) {
        performSegue(withIdentifier: "toMainVC", sender: nil)
        
        do{
            try Auth.auth().signOut()

        }catch{
            print("error!")
        }
        performSegue(withIdentifier: "toMainVC", sender: nil)
    }
    
    

}
