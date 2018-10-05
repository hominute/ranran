//
//  ChatRequest.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/11/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

struct FavoriteRequest : Mappable {
    
    var userId : Int64?
    var friendId : Int64?
 
    
    init(userId : Int64 , friendId : Int64) {
        self.userId = userId
        self.friendId = friendId

    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.userId <- map["userId"]
        self.friendId <- map["friendId"]
   
    }
    
}
