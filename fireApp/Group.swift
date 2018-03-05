//
//  Group.swift
//  fireApp
//
//  Created by A on 2/10/18.
//  Copyright © 2018 shady. All rights reserved.
//

import Foundation

class Group {
    
    private var _key: String!
    
    private var _title: String!
    
    private var _desc: String!
    
    private var _members: [String]!
    
    var key: String {
        
        get {
            if _key == nil {
                
                _key = ""
            }
            
            return _key
        }
        
        set {
            
            _key = newValue
        }
    }
    
    var title: String {
        
        get {
            
            if _title == nil {
                
                _title = ""
            }
            
            return _title
        }
        
        set {
            
            _title = newValue
        }
    }
    
    var desc: String {
        
        get {
            
            if _desc == nil {
                
                _desc = ""
            }
            
            return _desc
        }
        
        set {
            
            _desc = newValue
        }
    }
    
    var members: [String] {
        
        get {
            
            if _members == nil {
                
                _members = [String]()
            }
            
            return _members
        }
        
        set {
            
            _members = newValue
        }
    }
    
}
