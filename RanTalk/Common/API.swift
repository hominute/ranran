//
//  API.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class API: NSObject {
    
    static let ROOT = "https://dry-eyrie-61502.herokuapp.com/"
    static let SIGNIN = ROOT+"/users/login"
    static let SIGNUP = ROOT+"/users/signup"
    static let CHAT = ROOT+"/chats"
    static let INVITE = ROOT+"/chats/invite"
    static let ROOM = ROOT+"/chats/rooms"
    
}

