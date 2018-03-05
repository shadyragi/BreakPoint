//
//  groupCell.swift
//  fireApp
//
//  Created by A on 2/11/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit

class groupCell: UITableViewCell {

    @IBOutlet weak var groupTitle: UILabel!
    
    @IBOutlet weak var groupDesc: UILabel!
    
    
    @IBOutlet weak var membersCount: UILabel!
    
    func configureCell(group: Group) {
        
        self.groupTitle.text = group.title
        
        self.groupDesc.text = group.desc
        
        self.membersCount.text = "\(group.members.count) members"
        
    }

}
