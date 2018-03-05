//
//  createGroupVC.swift
//  fireApp
//
//  Created by A on 2/9/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit

class createGroupVC: UIViewController {
    
    
    @IBOutlet weak var titlelbl: UITextField!

    @IBOutlet weak var desclbl: UITextField!
    
    @IBOutlet weak var memberslbl: UITextField!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var selectedEmails: UILabel!
    
    
    
    var searchKey: String!
    
    var emails: [String] = [String]()
    
    var chosenEmails: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        memberslbl.delegate = self
        
        memberslbl.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
       
        
        
        // Do any additional setup after loading the view.
    }
    
   @objc func textDidChange() {
    
    if memberslbl.text == "" {
        
            emails = []
        }
    
    else {
        DataService.instance.searchForEmail(query: memberslbl.text!) { (returnedEmails) in
            
            self.emails = returnedEmails
            
        }
    }
    
    self.tableView.reloadData()

    
    }
    
  

    

    @IBAction func cancelBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        
        
        DataService.instance.getUsersIds(forEmails: self.chosenEmails) { (userIds) in
            
            DataService.instance.createGroup(withTitle: self.titlelbl.text!, andDesc: self.desclbl.text!, forUsers: userIds, completion: { (status) in
                
                if status {
                    
                    self.dismiss(animated: true, completion: nil)
                    
                } else {
                    
                    print("error has ocurred")
                    
                }
            })
        }
      
        
        
        
    }
    

}

extension createGroupVC: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return emails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var selected: Bool = false
        
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "searchCell") as? searchCell {
            
            
            if chosenEmails.contains(cell.email.text!) {
                
                selected = true
                
            } else {
                selected = false
            }
            
            cell.configureCell(emailValue: self.emails[indexPath.row], image: "defaultProfileImage", isSelected: selected)
            
            return cell
            
        
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedEmail = emails[indexPath.row]
        
        if chosenEmails.contains(selectedEmail) {
            
            chosenEmails = chosenEmails.filter({
                $0 != selectedEmail
            })
            
        } else {
            
            chosenEmails.append(selectedEmail)
        }
        
        if chosenEmails.count > 0 {
        
            self.selectedEmails.text = chosenEmails.joined(separator: ", ")
            
        } else {
            self.selectedEmails.text = "Add Members To Group"
        }
        
        
    }
    
    
}
