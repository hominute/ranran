//
//  MessageData.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class MessageData: Mappable {
    
    
    var chatType : String?
    var userId : Int64?
    var message : String?
    var createdDate : String?
    var photo : String?
    
    
    
    init() {
        
    }
    
    required init? (map: Map) {

    }
    
    
    func mapping(map: Map) {
        self.chatType <- map["chatType"]
        self.userId <- map["userId"]
        self.message <- map["message"]
        self.createdDate <- map["createdDate"]
        self.photo <- map["photo"]
    }
}

