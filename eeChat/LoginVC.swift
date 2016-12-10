//
//  LoginVC.swift
//  eeChat
//
//  Created by Evgeny Shkuratov on 12/8/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: ReoundTextField!
    @IBOutlet weak var passwordField: ReoundTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func loginPressed(_ sender: Any) {
        
        if let email = emailField.text, let pass = passwordField.text, (email.characters.count > 0 && pass.characters.count > 0) {

            AuthService.instance.login(email: email, password: pass, onComplete: { (errMsg, data) in
                guard errMsg == nil else {
                    let alert = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            })
            
        } else {
            let alert = UIAlertController(title: "Username and Password Required", message: "You must entered both a username and a password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

}
