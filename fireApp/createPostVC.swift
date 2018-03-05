//
//  createPostVC.swift
//  fireApp
//
//  Created by A on 2/6/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit

class createPostVC: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendPressed(_ sender: Any) {
        
        (sender as! UIButton).isEnabled = false
        
        if textView.text != nil {
            
            DataService.instance.uploadPost(withMessage: textView.text!, forUid: AuthService.instance.getUid(), forGroup: nil, completion: { (success) in
                
                if success {
                    
                    (sender as! UIButton).isEnabled = true
                    
                    self.dismiss(animated: true, completion: nil)
                }
                
                else {
                    
                    print("")
                }
            
            })
        }
        
    
    }


    @IBAction func cancelPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

}

extension createPostVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textView.text = ""
    }
}
