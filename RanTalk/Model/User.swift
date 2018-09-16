//
//  User.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

struct User : Mappable {
    
    var id : Int64?
    var email : String?
    var name : String?
    var statusmessage : String?

    
    init() {
        
    }
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.email <- map["email"]
        self.name <- map["name"]
        self.statusmessage <- map["statusMessage"]

    }
    
}
