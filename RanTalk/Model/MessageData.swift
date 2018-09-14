//
//  MessageData.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation
import ObjectMapper

struct MessageData:Mappable {
    
    
    var chatType : String?  // user id
    var userId : Int64? // user pass
    var message : String?
    
    init() {
        
    }
    
    init? (map: Map) {

    }
    
    
    mutating func mapping(map: Map) {
        self.chatType <- map["chatType"]
        self.userId <- map["userId"]
        self.message <- map["message"]
    }
}

