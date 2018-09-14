//
//  SendResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/14/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

struct SendResponse: Mappable {
    
    var message : String? = nil
    var error : String?

    
    
    init?(map: Map) {
        
        
        //    content = [MessageData]() as NSArray
        
        
    }
    
    mutating func mapping(map: Map) {
        self.message <- map["message"]
        self.error <- map["error"]
    
    }
    
    
}
