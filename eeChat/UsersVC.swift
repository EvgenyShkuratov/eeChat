//
//  UsersVC.swift
//  eeChat
//
//  Created by Evgeny Shkuratov on 12/10/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]()
    private var selectedUser = Dictionary<String, User>()
    
    private var _snapData: Data?
    private var _videoURL: URL?
    
    var snapData: Data? {
        set {
            _snapData = newValue
        } get {
           return _snapData
        }
    }
    
    var videoURL: URL? {
        set {
            _videoURL = newValue
        } get {
            return _videoURL
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
    
        DataService.instance.usersRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in

            if let users = snapshot.value as? Dictionary<String, AnyObject> {
                for (key, value) in users {
                    if let dict = value as? Dictionary<String, AnyObject> {
                        if let profile = dict["profile"] as? Dictionary<String, AnyObject> {
                            if let firstName = profile["firstName"] as? String {
                                let uid = key
                                let user = User(uid: uid, firstName: firstName)
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckMark(selected: true)
        let user = users[indexPath.row]
        selectedUser[user.uid] = user
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckMark(selected: false)
        let user = users[indexPath.row]
        selectedUser[user.uid] = nil
        
        if selectedUser.count <= 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @IBAction func sendPRBtnPressed(_ sender: Any) {
        
        if let url = _videoURL {
            let videoName = "\(NSUUID().uuidString)\(url)"
            let ref = DataService.instance.videoStorageRef.child(videoName)
            
            _ = ref.putFile(url, metadata: nil, completion: { (meta: FIRStorageMetadata?, err: Error?) in
                if err != nil {
                    print("Error uploading video: \(err?.localizedDescription)")
                } else {
                    let downloadURL = meta?.downloadURL()
                    DataService.instance.sendMediaPullRequest(senderUID: (FIRAuth.auth()?.currentUser!.uid)!, sendingTo: self.selectedUser, mediaURL: downloadURL!, TextSnipped: "Needs to have some UI for this feature..")
                    print("DownloadURL: \(downloadURL)")
                    // save this somewhere
                }
            })
            self.dismiss(animated: true, completion: nil)
        } else if let snap = _snapData {
            let imageName = "\(NSUUID().uuidString).jpg)"
            let ref = DataService.instance.imagesStorageRef.child(imageName)
            
            _ = ref.put(snap, metadata: nil, completion: { (meta: FIRStorageMetadata?, err: Error?) in
                if err != nil {
                    print("Error uploading snapshot: \(err?.localizedDescription)")
                } else {
                    let downloadURL = meta?.downloadURL()
                    print("DownloadURL: \(downloadURL)")
                    self.dismiss(animated: true, completion: nil)
                }
            })
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
}
