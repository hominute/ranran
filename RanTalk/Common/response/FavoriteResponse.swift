//
//  FavoriteResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 10/3/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation

import UIKit
import ObjectMapper

class FavoriteResponse: BaseResponse {

    var data : Bool?
    
    required init?(map: Map) {

    }
    
   override func mapping(map: Map) {
        self.data <- map["data"]
   
        
    }
    
    
}
