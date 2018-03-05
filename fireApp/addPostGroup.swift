//
//  addPostGroup.swift
//  fireApp
//
//  Created by A on 2/12/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit

class addPostGroup: UIViewController {
    
    
    
    @IBOutlet weak var addPost: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    var group: Group!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func cancelBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postBtnPressed(_ sender: Any) {
        
        var post: Message = Message()
        
        post.content = textView.text
        
        post.group_key = group.key
        
        post.user_id = AuthService.instance.getUid()
        
        DataService.instance.addPostInGroup(post: post) { (status) in
            
            if status {
                
                self.dismiss(animated: true, completion: nil)
                
            } else {
                
                print("error occurred")
                
            }
        }
        
    }
    
 
    
}
