//
//  ViewController.swift
//  eeChat
//
//  Created by Evgeny Shkuratov on 12/7/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import UIKit

class CameraVC: AAPLCameraViewController {

    @IBOutlet weak var previewView: AAPLPreviewView!
    
    override func viewDidLoad() {
        
        self._previewView = previewView
        
        super.viewDidLoad()
 
    }



}

