//
//  ChatTableViewCell.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import Kingfisher

class ChatTableViewCell: UITableViewCell {
    @IBOutlet var chatbutton: UIButton!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var lastMessage: UILabel!
    @IBOutlet var userName: UILabel!
    
    
    @IBOutlet var testuserId: UILabel!
    
    @IBOutlet var testroomId: UILabel!
    
    var roomId = Int64()
    var friendInfo : List?
    
    var delegte : ChatProtocol?
    
    @IBAction func testbutton(_ sender: Any) {
        
        
        self.delegte?.ChatCallback(roomId: self.roomId)
        
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
