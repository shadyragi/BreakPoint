//
//  MeVC.swift
//  fireApp
//
//  Created by A on 2/6/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit

class MeVC: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBOutlet weak var email: UILabel!
    
    
    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

    @IBAction func logoutPressed(_ sender: UIButton) {
        
        AuthService.instance.signOut(completion: {
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC")
            
            self.present(VC!, animated: true, completion: nil)
            
        })
        
        
        
    }
}
