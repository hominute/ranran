//
//  OtherTableViewCell.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import Kingfisher

class OtherTableViewCell: MessageTableViewCell {

    var userId = Int64()
    var profilClickDelegate : UserProfileProtocols?
    var delegte : UserinfoProtocol?
    var friendName = String()
    var statusMessage = String()
    var friendId = Int64()
    
    @IBOutlet var message: UILabel!
    
    
    @IBOutlet var createdDate: UILabel!
    
    
    @IBOutlet var friendImage: UIButton!
    
    @IBAction func friendInfo(_ sender: Any) {
        
        
        self.profilClickDelegate?.profileClickCallback(friendId: friendId ,friendName: friendName, statusmessage: statusMessage)
        
        
    }
   
    
    func imageLoad(url: String) {
        let url = URL(string: url)
        
        let modifier = AnyImageModifier { return $0.withRenderingMode(.alwaysOriginal) }
//        let resource = ImageResource(downloadURL: url!, cacheKey: "my_avatar")
        friendImage?.kf.setImage(with: url, for: .normal,  placeholder: nil, options: [.imageModifier(modifier)], progressBlock: nil, completionHandler: nil)
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
        message.layer.cornerRadius = message.frame.size.height / 5
        message.layer.masksToBounds = true
        
        
        friendImage.layer.cornerRadius = friendImage.frame.size.height / 2
        friendImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
