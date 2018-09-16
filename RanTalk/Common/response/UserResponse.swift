//
//  UserResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class UserResponse: BaseResponse, Mappable {
    
    var message : String? = nil
    var error : String?
    var user : User?
    var id : Int64?
    var email : String?
    var name : String?
    
   required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.user <- map["user"]
        self.message <- map["message"]
        self.error <- map["error"]
        self.id <- map["id"]
        self.email <- map["email"]
        self.name <- map["name"]
    }
    
    
}
