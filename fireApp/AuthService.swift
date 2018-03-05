//
//  AuthService.swift
//  fireApp
//
//  Created by A on 2/5/18.
//  Copyright © 2018 shady. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    static var instance = AuthService()
    
    
    func registerUser(email: String, pwd: String, completionHandler: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
            
            guard let user = user else {
                
                completionHandler(false, error)
                return
            }
            
            let userData = ["email": user.email, "providerID": user.providerID]
            
            DataService.instance.createDBUser(uid: user.uid, userData: userData as Dictionary<String, AnyObject>)
            
            completionHandler(true, nil)

        
        })
        
        
    }
    
    func loginUser(email: String, pwd: String, completionHandler: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        
        
        Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
            
            guard let user = user else {
                
                completionHandler(false, error)
                
                return
            }
            
            completionHandler(true, nil)
        })
        
        }
    
    func signOut(completion: @escaping () -> ()) {
        
        do {
            
            try Auth.auth().signOut()
            
            completion()
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
        }
        
        
    }
    
    func getUid() -> String {
        
        return (Auth.auth().currentUser?.uid)!
    }
}
    

