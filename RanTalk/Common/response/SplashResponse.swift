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

class SplashResponse: BaseResponse, Mappable {
    
    var data : Splash?
    var message : String? = nil
    var error : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.data <- map["data"]
        self.message <- map["message"]
        self.error <- map["error"]
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
