//
//  ChatResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/11/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class ChatResponse: BaseResponse, Mappable {
    
    var message : String? = nil
    var error : String?
    var user : User?
    var content : [MessageData]?
    var userId : Int64?
    var hoho : NSArray?
    
    
    required init?(map: Map) {
    
        
    }
    
    func mapping(map: Map) {
        self.user <- map["user"]
        self.message <- map["message"]
        self.error <- map["error"]
        self.content <- map["content"]
        self.userId <- map["userId"]
        self.hoho <- map["hoho"]
    }
    
    
}
