//
//  MyData.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/16/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class MyData <T: Mappable> : Mappable {
    
//    let datasd = T.selfr
    var content : [T]?

    
   init() {
        
    }
    
   required init? (map: Map) {
        
    
    }
    
    
   func mapping(map: Map) {
        self.content <- map["content"]
        
    }
}
