//
//  Notification.swift
//  fireApp
//
//  Created by A on 2/14/18.
//  Copyright © 2018 shady. All rights reserved.
//

import Foundation

class Notification {
    
    private var _id: String!
    
    private var _owner_id: String!
    
    private var _user_id: String!
    
    private var _message_id: String!
    
    private var _type: String!
    
    var type: String {
        
        get {
            
            if _type == nil {
                
                _type = ""
            }
            
            return _type
        }
        
        set {
            
            _type = newValue
        }
        
    }
    
    
    var id: String {
        
        get {
            
            if _id == nil {
                _id = ""
            }
            
            return _id
        }
        
        set {
            
            _id = newValue
        }
       
    }
    
    var owner_id: String {
        
        get {
            
            if _owner_id == nil {
                
                _owner_id = ""
            }
            
            return ""
        }
        
        set {
            
            _owner_id = newValue
        }
    }
    
    var user_id: String {
        
        get {
            
            if _user_id == nil {
                
                _user_id = ""
            }
            
            return _user_id
            
        }
        
        set {
            
            _user_id = newValue
        }
    }
    
    var message_id: String {
        
        get {
            
            if _message_id == nil {
                
                _message_id = ""
            }
            
            return _message_id
            
        }
        
        set {
            
            _message_id = newValue
        }
    }
    
    
    
    
    
    
}
