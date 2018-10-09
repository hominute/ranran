//
//  InviteResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/26/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class InviteResponse: BaseResponse {
    

    var data : Room?

    
    
    required init?(map: Map) {
        
        
        
    }
    
    override func mapping(map: Map) {

        self.data <- map["data"]
    }
    
    
}
