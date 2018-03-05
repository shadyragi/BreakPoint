//
//  searchCell.swift
//  fireApp
//
//  Created by A on 2/9/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit

class searchCell: UITableViewCell {

   
    @IBOutlet weak var profileImage: UIImageView!
    

    @IBOutlet weak var email: UILabel!
   
    @IBOutlet weak var checkMark: UIImageView!
    
    
    
    var showing: Bool = false
    
    func configureCell(emailValue: String, image: String, isSelected: Bool) {
        
        self.profileImage.image = UIImage(named: image)!
        
        self.email.text = emailValue
        
        if isSelected {
            
            checkMark.isHidden = false
        }
        else {
            
            checkMark.isHidden = true
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        if selected {
            
            if showing {
                
            
                checkMark.isHidden = true
            
                showing = false
            }
            
            else {
                
                checkMark.isHidden = false
                
                showing = true
            }
            
        }
    }

}
