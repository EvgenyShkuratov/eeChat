//
//  DataService.swift
//  eeChat
//
//  Created by Evgeny Shkuratov on 12/9/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

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
    
    var mainStorageRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    var imagesStorageRef: FIRStorageReference {
        return mainStorageRef.child("images")
    }
    
    var videoStorageRef: FIRStorageReference {
        return mainStorageRef.child("videos")
    }
    
    func sendMediaPullRequest(senderUID: String, sendingTo: Dictionary<String, User>, mediaURL: URL, TextSnipped: String? = nil) {
        
        let pr: Dictionary<String, AnyObject> = ["mediaURL":mediaURL.absoluteString as AnyObject, "userID":senderUID as AnyObject, "openCount":0 as AnyObject, "recipients":sendingTo.keys as AnyObject]
        mainRef.child("pullRequsts").childByAutoId().setValue(pr)
    }
    
    
    
    
}
