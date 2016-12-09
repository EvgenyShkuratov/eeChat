//
//  RoundButton.swift
//  eeChat
//
//  Created by Evgeny Shkuratov on 12/8/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var cornorRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornorRadius
            layer.masksToBounds = cornorRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }
    
    
    
}

