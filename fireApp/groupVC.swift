//
//  groupVC.swift
//  fireApp
//
//  Created by A on 2/5/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit

class groupVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var groups: [Group] = [Group]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        
        
        DataService.instance.downloadGroups { (groups) in
            
            self.groups = groups
            
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    

}

extension groupVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "groupCell") as? groupCell {
            
            var group: Group = self.groups[indexPath.row]
            
            
            cell.configureCell(group: group)
            
            return cell
            
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let group: Group = self.groups[indexPath.row]
        
        performSegue(withIdentifier: "groupFeed", sender: group)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? groupFeed {
            
            if let sender = sender as? Group {
                
                    dest.group = sender
            }
        }
    }
    
}
