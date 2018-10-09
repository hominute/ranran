//
//  SplashResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/22/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation

import UIKit
import ObjectMapper

class SplashResponse:  BaseResponse {
    
    var data : Splash?

    
    required init?(map: Map) {

    }
    
    override func mapping(map: Map) {
        self.data <- map["data"]

    }
    
    class Splash : Mappable {
        
        var title : String?
        var description : String?
        
        
        init() {
            
        }
        
        
        required init?(map: Map) {
            
        }
        
        func mapping(map: Map) {
            self.title <- map["title"]
            self.description <- map["description"]
            
        }
        
    }
}
