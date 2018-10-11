//
//  PRTableViewCell.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/21/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class PRTableViewCell: ProfileTableViewCell {
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet var prTextview: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
