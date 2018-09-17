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
    
    var delegate: InviteProtocol?
    

   
    
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var shortMessage: UILabel!
    
    @IBAction func chatInvite(_ sender: Any) {

        
        self.delegate?.inviteCallback(roomId:2)
        let uds = UserDefaults.standard

//        self.myId = uds.integer(forKey: "id")
        self.myId = 2
        
        
        
        
//        SecondApi.instance().makeAPICalls(url: url, params: bodyString, method: .POST, success: {(data, response, error, responsedata) in
//            // API call is Successfull
//
//            let respondata = responsedata
//
//            DispatchQueue.main.async {
//
//                if ((respondata.contains("message"))) {
//
//                    MyDTO().DTO(type: "message", repondata: respondata, userdatas: { (userdatad) in
//
//                        let errormessage = userdatad
//                        print("\(errormessage)")
////                        self.displayMessage(userMessage: "\(errormessage)")
//
//
//
//                    }
//                    )
//
//                } else {
//
//                    self.delegate?.inviteCallback(roomId:2)
//                }
//            }
//
//            return
//
//        }, failure: {(data, response, error) in
//
//        }
//
//        )
        
        
    }
    
    @IBOutlet var userName: UILabel!
    
//Utility Func
    
    func imageLoad(url: String) {
        let url = URL(string: url)
        
        userImage?.kf.setImage(with: url)
        
    }
    
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    


}
