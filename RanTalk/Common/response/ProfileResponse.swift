//
//  ProfileResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/22/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation

import UIKit
import ObjectMapper

class ProfileResponse: BaseResponse, Mappable {
    
    var message : String? = nil
    var error : String?
    var user : Profile?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.user <- map["data"]
        self.message <- map["message"]
        self.error <- map["error"]
      
    }
    
    
}
