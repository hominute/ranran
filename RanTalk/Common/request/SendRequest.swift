//
//  SendRequest.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/14/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

struct SendRequest : Mappable, Codable {
    
    
    var message : String?
    var roomId : Int64?
    var userId : Int64?
    
    init(message : String , roomId : Int64 , userId : Int64 ) {
        self.message = message
        self.roomId = roomId
        self.userId = userId
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.message <- map["message"]
        self.roomId <- map["roomId"]
        self.userId <- map["userId"]
    }
    
}
