//
//  AuthService.swift
//  eeChat
//
//  Created by Evgeny Shkuratov on 12/9/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completoin = (_ errMsg: String?, _ data: AnyObject?) -> Void

class AuthService {
    
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: Completoin?) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                if let errorCode = FIRAuthErrorCode(rawValue: error!._code) {
                    if errorCode == .errorCodeUserNotFound {
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.handleFirebaseError(error: error as! NSError, onComplete: onComplete)
                            } else {
                                if user?.uid != nil {
                                    //sign in
                                    DataService.instance.saveUser(uid: user!.uid)
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            self.handleFirebaseError(error: error as! NSError, onComplete: onComplete)
                                        } else {
                                            onComplete?(nil, user)
                                        }
                                    })
                                }
                            }
                        })
                        
                    }
                } else {
                    self.handleFirebaseError(error: error as! NSError, onComplete: onComplete)
                }
            } else {
                onComplete?(nil, user)
            }
        })
    }
    
    func handleFirebaseError(error: NSError, onComplete: Completoin?) {
        print(error.debugDescription)
        if let errorCode = FIRAuthErrorCode(rawValue: error._code) {
            switch errorCode {
            case .errorCodeInvalidEmail:
                onComplete?("Invalid email address", nil)
                break
            case .errorCodeWrongPassword:
                onComplete?("Invalid passsword", nil)
                break
            case .errorCodeEmailAlreadyInUse, .errorCodeAccountExistsWithDifferentCredential:
                onComplete?("Could not create account. Email already in use.", nil)
                break
            default:
                onComplete?("There was a problem authenticating. Try again.", nil)
            }
        }
    }
    
    
    
    
}
