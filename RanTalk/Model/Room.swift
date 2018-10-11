//
//  Room.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/16/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

struct Room : Mappable {
    
    var roomId : Int64?
    var friendInfo : UserList?
    var lastchat : String?
    
    
    
    init() {
        
    }
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.roomId <- map["roomId"]
        self.friendInfo <- map["friendInfo"]
        self.lastchat <- map["lastChat"]
  
        
    }
    
}

