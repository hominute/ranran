//
//  ProfileRequest.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/22/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

struct ProfileRequest : Mappable {
    
    var userId : Int64?
//    var name : String?
//    var statusMessage : String?
    
    init(userId : Int64 ) {
        self.userId = userId
//        self.name = name
//        self.statusMessage = statusMessage
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.userId <- map["userId"]
//        self.name <- map["name"]
//        self.statusMessage <- map["statusMessage"]
    }
    
}

