//
//  feedVC.swift
//  fireApp
//
//  Created by A on 2/5/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit


class feedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages = [Message]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        DataService.instance.downloadPosts { (returnedMessages) in
            
            
            self.messages = returnedMessages
            
            self.tableView.reloadData()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? feedCell {
            
            var message = messages[indexPath.row]
            
            
            DataService.instance.isLiked(message_id: message.id, handler: { (isLiked) in
                
                print("status is \(isLiked)")
               cell.configureCell(message: message, isLiked: isLiked)
            })
            
            
            
            return cell
            
        }
        
        return UITableViewCell()
        
    }
    
    
    @IBAction func likeBtnTapped(_ sender: UIButton) {
        
        var cell: UITableViewCell = (sender.superview?.superview as? UITableViewCell)!
        
       let index =  self.tableView.indexPath(for: cell)
        
        let message = self.messages[(index?.row)!]
        
        DataService.instance.likeMessage(message: message) { (status) in
            
            if status {
                
                sender.setTitle("Unlike", for: .normal)
                
            } else {
                
                print("error happened")
                
            }
        }
        
    }


}
