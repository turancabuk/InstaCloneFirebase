//
//  FeedCell.swift
//  instaCloneFirebase
//
//  Created by Turan Çabuk on 22.08.2022.
//

import UIKit

class FeedCell: UITableViewCell{

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        print("like button clicked")
    }
    
}
