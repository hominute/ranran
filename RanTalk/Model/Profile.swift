//
//  UserInfo.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/22/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

struct Profile : Mappable {
    
    var title = ["이메일", "닉네임", "포인트", "상태메시지", "사진"]
    var id : Int64?
    var email : String?
    var name : String?
    var point : Int64?
    var statusmessage : String?
    var photo : String?
    var value = ["", "", "", "", ""]
    init() {
        
     
        
    }
    
    
    init?(map: Map) {
        
//        self.value = ["\(self.id!)","\(self.email!)","\(self.name!)","\(self.point!)","\(self.statusmessage!)"]
        
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.email <- map["email"]
        self.name <- map["name"]
        self.point <- map["point"]
        self.statusmessage <- map["statusMessage"]
        self.photo <- map["photo"]
//        self.value <- map[self.id,self.email,self.name,self.point,self.photo]
        
    }
    
}

