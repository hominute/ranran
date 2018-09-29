//
//  UserTableViewCell.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

import Kingfisher

class UserTableViewCell: ListTableViewCell{
    
    
    var myId = Int64()
    var friendId = Int64()
    var inviteClickDelegate: InviteProtocol?
 
    
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var shortMessage: UILabel!
    
    @IBAction func chatInvite(_ sender: Any) {
    
        self.inviteClickDelegate?.inviteClickCallback(friendId: friendId)
        
    }
    
    @IBOutlet var userName: UILabel!
    
//Utility Func
    
    func imageLoad(url: String) {
        if let url = url {
            let url = URL(string: url)
        
            userImage?.kf.setImage(with: url)
        }
    }
    
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImage?.layer.borderWidth = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    


}
