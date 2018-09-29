//
//  InviteRequest.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/26/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

struct InviteRequest : Mappable {
    
    
    var friendId : Int64?
    var userId : Int64?
    
    init(friendId : Int64 , userId : Int64) {
        self.friendId = friendId
        self.userId = userId

    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.friendId <- map["friendId"]
        self.userId <- map["userId"]

    }
    
}

