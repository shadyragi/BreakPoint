//
//  loginVC.swift
//  fireApp
//
//  Created by A on 2/5/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit

class loginVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    @IBAction func signinBtnTapped(_ sender: UIButton) {
        
       
        if let email = emailField.text, let password = passwordField.text {
            
            AuthService.instance.loginUser(email: email, pwd: password, completionHandler: {(success, error) in
                
                if success {
                    
                    var mainVC = self.storyboard?.instantiateViewController(withIdentifier: "mainVC")
                    
                    self.present(mainVC!, animated: true, completion: nil)
                    
                    
                }
                
                else {
                    print(error?.localizedDescription)
                }
            })
            
        }
    }
    
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
