//
//  Message.swift
//  fireApp
//
//  Created by A on 2/6/18.
//  Copyright © 2018 shady. All rights reserved.
//

import Foundation

class Message {
    
    private var _id: String!
    
    private var _content: String!
    
    private var _user_id: String!
    
    private var _group_key: String!
    
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
    
    var content: String {
        
        get {
            if _content == nil {
                _content = ""
            }
            return _content
        }
        
        set {
            
            _content = newValue
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
    
    var group_key: String {
        
        get {
            if _group_key == nil {
                
                _group_key = ""
            }
            return _group_key
        }
        set {
            
            _group_key = newValue
        }
    }
    
}
