//
//  ChatRequest.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/11/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

struct ChatRequest : Mappable {
    
    var roomId : Int64?
    var userId : Int64?
    var page : Int64?
    var size : Int64?
    
    init(roomId : Int64 , userId : Int64 , page : Int64 , size : Int64 ) {
        self.roomId = roomId
        self.userId = userId
        self.page = page
        self.size = size
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.roomId <- map["roomId"]
        self.userId <- map["userId"]
        self.page <- map["page"]
        self.size <- map["size"]
    }
    
}
