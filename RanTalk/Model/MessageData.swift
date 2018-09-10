//
//  MessageData.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation


class MessageData {
    
    
    
    var messageType : String?  // user id
    var userId : Int64? // user pass
    var message : String?
    
    init (messageType : String?, userId: Int64?, message : String?) {
        
        
        self.messageType = messageType
        self.userId = userId
        self.message = message
        
        
    }
    
    
}
