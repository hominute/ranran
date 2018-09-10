//
//  ChatResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/11/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

struct ChatResponse: Mappable {
    
    var message : String? = nil
    var error : String?
    var user : User?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.user <- map["user"]
        self.message <- map["message"]
        self.error <- map["error"]
    }
    
    
}
