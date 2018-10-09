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

class ProfileResponse: BaseResponse {

    var user : Profile?

    required init?(map: Map) {
    }
    
    override func mapping(map: Map) {
        self.user <- map["data"]

      
    }
    
    
}
