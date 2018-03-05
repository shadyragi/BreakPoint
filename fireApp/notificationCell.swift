//
//  notificationCell.swift
//  fireApp
//
//  Created by A on 2/14/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit

class notificationCell: UITableViewCell {

    @IBOutlet weak var email: UILabel!
   
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var user_image: UIImageView!
    
    func configureCell(notif: Notification) {
        
        DataService.instance.getEmail(uid: notif.user_id) { (email) in
            
            self.email.text = email
            
        }
        
        self.content.text = "has \(notif.type)ed your post"
        
        self.user_image.image = UIImage(named: "defaultProfileImage")
    }
    

}
