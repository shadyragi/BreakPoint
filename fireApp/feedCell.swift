//
//  feedCell.swift
//  fireApp
//
//  Created by A on 2/6/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
 
    @IBOutlet weak var email: UILabel!

    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    
    
    func configureCell(message: Message, isLiked: Bool) {
        
        content.text = message.content
        
        profileImage.image = UIImage(named: "defaultProfileImage")
        
        DataService.instance.getEmail(uid: message.user_id, completion: {(email) in
            
            self.email.text = email
        })
        
        if isLiked {
            
         
            
            self.likeBtn.setTitle("Unlike", for: .normal)
            
        } else {
            
            self.likeBtn.setTitle("Like", for: .normal)
        }
        
       
        
        
        
    }
  
    @IBAction func likeBtnTapped(_ sender: Any) {
    }
    
    
    
    
    
    
}
