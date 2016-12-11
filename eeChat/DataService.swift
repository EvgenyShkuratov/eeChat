//
//  DataService.swift
//  eeChat
//
//  Created by Evgeny Shkuratov on 12/9/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataService {
    
    private static var _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }

    var mainRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var usersRef: FIRDatabaseReference {
        return mainRef.child("users")
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, AnyObject> = ["firstName": "" as AnyObject, "lastName": "" as AnyObject]
        mainRef.child("Users").child(uid).child("Profile").setValue(profile)
    }
    
    
    
}
