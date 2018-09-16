//
//  List.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/14/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class List : Mappable {
    
    var id : Int64?
    var email : String?
    var name : String?
    var photo : String?
    var point : Int64?
    var statusMessge : String?
    
   init() {
        
    }
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.email <- map["email"]
        self.name <- map["name"]
        self.photo <- map["photo"]
        self.point <- map["point"]
        self.statusMessge <- map["statusMessage"]
    }
    
}
