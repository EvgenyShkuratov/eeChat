//
//  UserCell.swift
//  eeChat
//
//  Created by Evgeny Shkuratov on 12/10/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    

    @IBOutlet weak var firstNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCheckMark(selected: false)

    }

    func setCheckMark(selected: Bool) {
        
        let imageStr = selected ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imageStr))
    }

    func updateUI(user: User) {
        firstNameLbl.text = user.firstName
    }
    
    
    
}
