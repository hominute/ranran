//
//  BaseResponse.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/15/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation

import UIKit
import ObjectMapper


class BaseResponse: Mappable {

    var error : message?
    var apiversion : Int64?
    
    
    init() {
        
    }
    
   convenience required init?(map: Map) {
     self.init()
    }
    
    func mapping(map: Map) {
        self.apiversion <- map["apiVersion"]
        self.error <- map["error"]
        
    }
    
    class message : Mappable {
        
        var message : String?

        init() {
            
        }
        
        
        required init?(map: Map) {
            
        }
        
        func mapping(map: Map) {
            self.message <- map["message"]
       
            
        }
        
    }
}


