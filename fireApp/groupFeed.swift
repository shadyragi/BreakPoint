//
//  groupFeed.swift
//  fireApp
//
//  Created by A on 2/12/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit

class groupFeed: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var group: Group!
    
    var posts: [Message] = [Message]()
    
    @IBOutlet weak var groupLbl: UILabel!

    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        groupLbl.text = group.title
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        
        DataService.instance.downloadPostsInGroup(group_id: group.key) { (posts) in
            
            self.posts = posts
            
            self.tableView.reloadData()
        }
    }
    @IBAction func cancelBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPostPressed(_ sender: Any) {
        
        
        
        performSegue(withIdentifier: "addPostGroup", sender: group)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? addPostGroup {
            
            if let sender = sender as? Group {
                
                dest.group = sender
            }
        }
    }

}


extension groupFeed: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "groupPost") as? groupPost {
            
            let post = self.posts[indexPath.row]
            
            cell.configureCell(message: post)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}


