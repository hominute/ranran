//
//  ChatTableViewCell.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    @IBOutlet var chatbutton: UIButton!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var lastMessage: UILabel!
    
    @IBAction func testbutton(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func imageLoad(url: String) {
        let url = URL(string: url)
        
        userImage?.kf.setImage(with: url)
        
    }
    

}
