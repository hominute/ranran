//
//  ProfileTableViewCell.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/21/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: ProfileTableViewCell {

    
    @IBOutlet var listname: UILabel!
    
    @IBOutlet var value: UILabel!
    
    
    
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        value.text = ""
            
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    }

}
