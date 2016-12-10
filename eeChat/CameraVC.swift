//
//  CameraVC.swift
//  eeChat
//
//  Created by Evgeny Shkuratov on 12/7/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: AAPLCameraViewController, AAPLCameraVCDelegate {

    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var previewView: AAPLPreviewView!
    
    override func viewDidLoad() {
        delegate = self

        _previewView = previewView
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {

        guard FIRAuth.auth()?.currentUser != nil else {
            performSegue(withIdentifier: "LoginVC", sender: nil)
            return
        }
    
    }

    @IBAction func recordBtnPressed(_ sender: Any) {
        toggleMovieRecording()
    }

    @IBAction func changeCameraBtnPressed(_ sender: Any) {
        changeCamera()
    }

    func shouldEnableCameraUI(_ enable: Bool) {
        cameraBtn.isEnabled = enable
    }
    
    func shouldEnableRecordUI(_ enable: Bool) {
        recordBtn.isEnabled = enable
    }
    
    func recordingHasStarted() {
        print("Recording has started")
    }
    
    func canStartRecording() {
        print("can start recording")
    }
    
    func videoRecordingComplete(_ videoURL: URL!) {
        
    }
    
    func videoRecordingFailed() {
        
    }
    
    func snapshotTaken(_ snapshotData: Data!) {
        
    }
    
    func snapshotFailed() {
        
    }
}

