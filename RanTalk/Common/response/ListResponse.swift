//
//  ListResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/14/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

struct ListResponse: Mappable {
    
    var message : String? = nil
    var error : String?
    var user : User?
    var content : [List]?
    var userId : Int64?
    var hoho : NSArray?
    
    
    init?(map: Map) {
        
        
        //    content = [MessageData]() as NSArray
        
        
    }
    
    mutating func mapping(map: Map) {
        self.user <- map["user"]
        self.message <- map["message"]
        self.error <- map["error"]
        self.content <- map["content"]
        self.userId <- map["userId"]
        self.hoho <- map["hoho"]
    }
    
    
}
