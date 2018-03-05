//
//  groupPost.swift
//  fireApp
//
//  Created by A on 2/12/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit

class groupPost: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var post: UILabel!
    
    
    func configureCell(message: Message) {
        
        self.profileImage.image = UIImage(named: "defaultProfileImage")
        
        self.post.text = message.content
        
        DataService.instance.getEmail(uid: message.user_id) { (email) in
            
            self.email.text = email
        }
    }

}
