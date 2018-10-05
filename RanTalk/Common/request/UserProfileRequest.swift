//
//  ListRequest.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/14/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

struct UserProfileRequest : Mappable {
    
    
    var userId : Int64?
    var page : Int64?
    var size : Int64?
    
    init(userId : Int64 , page : Int64 , size : Int64 ) {
        self.userId = userId
        self.page = page
        self.size = size
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.userId <- map["userId"]
        self.page <- map["page"]
        self.size <- map["size"]
    }
    
}
