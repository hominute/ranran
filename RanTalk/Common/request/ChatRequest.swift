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
    
    init(name : Int64 , email : Int64 , password : Int64 , size : Int64 ) {
        self.roomId = name
        self.userId = email
        self.page = password
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
