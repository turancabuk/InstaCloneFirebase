//
//  FeedViewController.swift
//  instaCloneFirebase
//
//  Created by Turan Çabuk on 21.08.2022.
//

import UIKit
import Firebase
import FirebaseFirestore



class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var userEmailArray = [String]()
    var likeArray = [Int]()
    var commentArray = [String]()
    var userImageArray = [String]()

    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        getDataFromFirebase()
    }
    func getDataFromFirebase() {
        
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Posts").addSnapshotListener { snapShot, error in
            
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if snapShot?.isEmpty != true {
                    for document in snapShot!.documents {
                        let documentID = document.documentID
                        
                        if let postedBy = document.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        if let likes = document.get("likes") as? Int{
                            self.likeArray.append(likes)
                        }
                        if let postComment = document.get("postComment") as? String{
                            self.commentArray.append(postComment)
                        }
                        if let imageURL = document.get("imageURL") as? String{
                            self.userImageArray.append(imageURL)
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        
        
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.commentLabel.text = commentArray[indexPath.row]
        cell.userImageView.image = UIImage(named: "select")
        return cell
    }
    
    

}
