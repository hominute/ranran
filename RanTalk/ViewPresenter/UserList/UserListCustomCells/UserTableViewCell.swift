//
//  UserTableViewCell.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

import Kingfisher

class UserTableViewCell: UserListTableViewCell{
    
    
    var myId = Int64()
    var friendId = Int64()
    var friendName = String()
    var statusmessage = String()
    var inviteClickDelegate: InviteProtocol?
    var profilClickDelegate : UserProfileProtocols?
    
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var shortMessage: UILabel!
    
    @IBAction func chatInvite(_ sender: Any) {
    
        self.inviteClickDelegate?.inviteClickCallback(friendId: friendId)
        
    }
    
    @IBOutlet var userName: UILabel!
    
//Utility Func
    
    func imageLoad(imageUrl: String?) {
        if let imageUrl = imageUrl {
            let url = URL(string: imageUrl)
        
            userImage?.kf.setImage(with: url)
        
            
        }
    }
    
    
    func clickProfile (){
        
        self.profilClickDelegate?.profileClickCallback(friendId : friendId, friendName : friendName, statusmessage : statusmessage)
        print("click profile")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImage?.layer.borderWidth = 1
        let customview = UIView()
        customview.backgroundColor = UIColor.rgba(red: 138, green: 176, blue: 240, alpha: 0.5)
        self.selectedBackgroundView = customview
        userImage?.layer.cornerRadius = userImage.bounds.width * 0.5
        
    }

    
    func setupCell(userlist: UserList) {
        imageLoad(imageUrl: userlist.photo ?? "")
        self.shortMessage.text = userlist.statusMessge ?? ""
        self.userName.text = userlist.name ?? ""
        self.friendId = userlist.id ?? 0
        self.friendName = userlist.name ?? ""
        self.statusmessage = userlist.statusMessge ?? ""
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
        // Configure the view for the selected state
    }
    

    
    


}
