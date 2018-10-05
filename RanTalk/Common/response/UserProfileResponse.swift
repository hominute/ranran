//
//  ListResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/14/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class UserProfileResponse: BaseResponse, Mappable {
    
    var message : String? = nil
    var error : String?
    var user : User?
    var data : List?
    var userId : Int64?

    
    
    required init?(map: Map) {
        
        
        //    content = [MessageData]() as NSArray
        
        
    }
    
    func mapping(map: Map) {
        self.user <- map["user"]
        self.message <- map["message"]
        self.error <- map["error"]
        self.data <- map["data"]
        self.userId <- map["userId"]
   
    }
    
    
}
