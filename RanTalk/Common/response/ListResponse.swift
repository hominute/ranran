//
//  ListResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/14/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class ListResponse: BaseResponse, Mappable {
    
    var message : String? = nil
    var error : String?
    var user : User?
    var data : MyData<List>?
    var userId : Int64?
    var hoho : NSArray?
    
    
    required init?(map: Map) {
        
        
        //    content = [MessageData]() as NSArray
        
        
    }
    
    func mapping(map: Map) {
        self.user <- map["user"]
        self.message <- map["message"]
        self.error <- map["error"]
        self.data <- map["data"]
        self.userId <- map["userId"]
        self.hoho <- map["hoho"]
    }
    
    
}
