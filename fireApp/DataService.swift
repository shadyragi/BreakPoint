//
//  DataService.swift
//  fireApp
//
//  Created by A on 2/5/18.
//  Copyright © 2018 shady. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    
    static var instance = DataService()
    
    private var _REF_USERS = DB_BASE.child("users")
    
    private var _REF_GROUPS = DB_BASE.child("groups")
    
    private var _REF_FEED = DB_BASE.child("feed")
    
    private var _REF_LIKES = DB_BASE.child("likes")
    
    private var _REF_NOTIFICATIONS = DB_BASE.child("notifications")
    
    var REF_NOTIFICATIONS: DatabaseReference {
        
        return _REF_NOTIFICATIONS
        
    }
    
    var REF_USERS: DatabaseReference {
        
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        
        return _REF_FEED
    }
    
    var REF_LIKES: DatabaseReference {
        
        return _REF_LIKES
        
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, AnyObject>) {
       
        _REF_USERS.child(uid).updateChildValues(userData)
        
        
    }
    
    
    func uploadPost(withMessage message: String, forUid uid: String, forGroup groupKey: String?, completion: @escaping (_ status: Bool) -> ()) {
        
        if groupKey != nil {
            
        } else {
            
            _REF_FEED.childByAutoId().updateChildValues(["message": message, "user_id": uid, "group_id": ""])
            
            completion(true)
            
        }
        
        
    }
    
    func downloadPosts(handler: @escaping ([Message]) -> ()) {
        
        var messageArray = [Message]()
        
        REF_FEED.observeSingleEvent(of: .value, with: {(snapshot) in
            
            for message in snapshot.children.allObjects as! [DataSnapshot] {
                
                if (message.childSnapshot(forPath: "group_id").value as? String) == "" {
                
                var messageObj = Message()
                
                messageObj.content = message.childSnapshot(forPath: "message").value as! String
                
                messageObj.user_id = message.childSnapshot(forPath: "user_id").value as! String
                
                messageObj.group_key = ""
                
                messageObj.id = message.key
                    
                
                
                messageArray.append(messageObj)
                }
            }
            
            handler(messageArray)
            
        })
        
    }
    
    func getEmail(uid: String, completion: @escaping (_ email: String) -> ())  {
        
        var email: String!
        
        print("user id is \(uid)")
        
        REF_USERS.child(uid).observe(.value, with: { (snapshot) in
            
            if let dicit = snapshot.value as? Dictionary<String, String> {
                
                completion(dicit["email"]!)
                
            }
        })
     
        
       
        
    }
    
    func searchForEmail(query: String, completion: @escaping ([String]) -> ()) {
        
        REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            
            var emails: [String] = [String]()
            
            for user in snapshot.children.allObjects as! [DataSnapshot] {
                
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) {
                    
                    emails.append(email)
                    
                }
            }
            
            completion(emails)
        })
        
    }
    
    func getUsersIds(forEmails emails: [String], handler: @escaping (_ ids: [String]) -> ()) {
        
        var userIds = [String]()
        
        _REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            
            for user in snapshot.children.allObjects as! [DataSnapshot] {
                
                let user_email = user.childSnapshot(forPath: "email").value as! String
                
                if emails.contains(user_email) {
                    
                    userIds.append(user.key)
                }
                
            }
            
            handler(userIds)
            
            
        })
        
    }
    
    func createGroup(withTitle title: String, andDesc desc: String, forUsers users: [String], completion: @escaping (_ status: Bool) -> ()) {
        
        let data = ["title": title, "description": desc, "members": users] as [String : Any]
        
        self._REF_GROUPS.childByAutoId().updateChildValues(data) { (error, group) in
            
            if let error = error {
                
                completion(false)
                
            } else {
                
                completion(true)
            }
            
            
        }
        
    
        
    }
    
    
    func downloadGroups(handler: @escaping (_ groups: [Group]) -> ()) {
        
        self._REF_GROUPS.observe(.value, with: { (snapshot) in
            
            var groups: [Group] = [Group]()
            
            for singleGroup in snapshot.children.allObjects as! [DataSnapshot] {
                
                var group = Group()
                
                group.title = singleGroup.childSnapshot(forPath: "title").value as! String
                
                group.desc = singleGroup.childSnapshot(forPath: "description").value as! String
                
                group.members = singleGroup.childSnapshot(forPath: "members").value as! [String]
                
                group.key = singleGroup.key
                
                groups.append(group)
                
            }
            
            handler(groups)
            
            
        })
        
    }
    
    func addPostInGroup(post: Message, completion: @escaping (_ status: Bool) -> ()) {
        
 
        self._REF_FEED.childByAutoId().updateChildValues(["message": post.content, "user_id": post.user_id, "group_id": post.group_key]) { (error, post) in
            
            if let error = error {
                
                completion(false)
                
            } else {
                
                completion(true)
            }
        }
    }
    
    func downloadPostsInGroup(group_id: String, completion: @escaping ([Message]) -> ()) {
        
        
        self._REF_FEED.observe(.value, with: { (snapshot) in
            
            var posts: [Message] = [Message]()
            
            for post in snapshot.children.allObjects as! [DataSnapshot] {
                
                let _group_id = post.childSnapshot(forPath: "group_id").value as! String
                
                if _group_id == group_id {
                
                var message: Message = Message()
                    
                message.content = post.childSnapshot(forPath: "message").value as! String
                    
                message.user_id = post.childSnapshot(forPath: "user_id").value as! String
                    
                message.group_key = post.childSnapshot(forPath: "group_id").value as! String
                    
                posts.append(message)
                
                
                }
            }
            
            completion(posts)
            
        })
        
    }
    
    func likeMessage(message: Message, completion: @escaping (_ status: Bool) -> ()) {
        
        
        
        let user_id = AuthService.instance.getUid()
        
        let message_id = message.id
        
        _REF_LIKES.childByAutoId().updateChildValues(["message_id": message_id, "user_id": user_id]) { (error, like) in
            
            if let error = error {
                
                completion(false)
            } else {
                
                self.triggerNotification(message: message, type: "like", handler: { (notifTriggered) in
                    
                    if notifTriggered {
                        
                        completion(true)
                        
                    } else {
                        
                        completion(false)
                    }
                    
                    
                })
                
              
            }
            
        }
        
        
    }
    
    func isLiked(message_id: String, handler: @escaping (_ liked: Bool) -> ()) {
        
        self._REF_LIKES.observeSingleEvent(of: .value, with: { (snapshot) in
            
            for like in snapshot.children.allObjects as! [DataSnapshot] {
                
                var user_id = AuthService.instance.getUid()
                
                if (like.childSnapshot(forPath: "message_id").value as! String) == message_id {
                    
                    
                    
                    if user_id == (like.childSnapshot(forPath: "user_id").value as! String) {
                        
                        
                        handler(true)
                        
                        return
                    }
                }
                
            }
            handler(false)
        })
    }
    
    
    func triggerNotification(message: Message, type: String , handler: @escaping (_ status: Bool) -> ()) {
        
        let id = AuthService.instance.getUid()
        
        self._REF_NOTIFICATIONS.childByAutoId().updateChildValues(["owner_id": message.user_id, "user_id": id, "type": type, "message_id": message.id]) { (error, notif) in
            
            if let error = error {
                
                handler(false)
                
            } else {
                
                handler(true)
            }
            
        }
        
    }
    
    
    func getNotifications(user_id: String, handler: @escaping (_ notifications: [Notification]) -> ()) {
        
        
        
        self._REF_NOTIFICATIONS.observe(.value, with: { (snapshot) in
            
            var notifications = [Notification]()
            
            for notif in snapshot.children.allObjects as! [DataSnapshot] {
                
                let user_id = notif.childSnapshot(forPath: "owner_id").value as! String
                
                if user_id == AuthService.instance.getUid() {
                
                var notification = Notification()
                
                notification.message_id = notif.childSnapshot(forPath: "message_id").value as! String
                
                notification.owner_id = notif.childSnapshot(forPath: "owner_id").value as! String
                
                notification.type = notif.childSnapshot(forPath: "type").value as! String
                
                notification.user_id = notif.childSnapshot(forPath: "user_id").value as! String
                
                notifications.append(notification)
                    
                
                    
            }
                
                
            }
            
            handler(notifications)
            
        })
        
    }
    
    
}
