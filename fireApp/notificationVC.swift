//
//  notificationVC.swift
//  fireApp
//
//  Created by A on 2/14/18.
//  Copyright © 2018 shady. All rights reserved.
//

import UIKit

class notificationVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notifications: [Notification] = [Notification]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        DataService.instance.getNotifications(user_id: AuthService.instance.getUid()) { (notifs) in
            
            print("count is \(notifs.count  )")
            
            self.notifications = notifs
            
            self.tableView.reloadData()
        }

    
    }


}

extension notificationVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell") as? notificationCell {
            
            let notification = notifications[indexPath.row]
            
            cell.configureCell(notif: notification)
            
            return cell
        }
        
        
        return UITableViewCell()
    }
}
