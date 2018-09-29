//
//  InviteResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/26/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class InviteResponse: BaseResponse, Mappable {
    
    var message : String? = nil
    var error : String?
    var data : Room?

    
    
    required init?(map: Map) {
        
        
        //    content = [MessageData]() as NSArray
        
        
    }
    
    func mapping(map: Map) {
        self.message <- map["message"]
        self.error <- map["error"]
        self.data <- map["data"]
    }
    
    
}
