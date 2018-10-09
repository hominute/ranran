//
//  UserResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class UserResponse: BaseResponse{
    

    var user : User?


    
    required init?(map: Map) {

    }
    
   override func mapping(map: Map) {
        super.mapping(map: map)
        self.user <- map["data"]
    }
    
    
}
