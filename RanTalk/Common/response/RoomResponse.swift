//
//  RoomRequest.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/16/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class RoomResponse: BaseResponse {
    

    var user : User?
    var data : MyData<Room>?
    var userId : Int64?
  
    
    
    required init?(map: Map) {

        
        
    }
    
    override func mapping(map: Map) {
        self.user <- map["user"]
        self.data <- map["data"]
        self.userId <- map["userId"]


    }
    
    
}
