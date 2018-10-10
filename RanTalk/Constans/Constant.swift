//
//  Constant.swift
//  RanTalk
//
//  Created by KIM HO MIN on 10/11/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation

struct APIConstant {
    
    
    
    static let ROOT = "https://dry-eyrie-61502.herokuapp.com"
    static let SIGNIN = ROOT+"/users/login"
    static let SIGNUP = ROOT+"/users/signup"
    static let LIST = ROOT+"/users/"
    static let CHAT = ROOT+"/chats"
    static let INVITE = ROOT+"/rooms/invite"
    static let ROOM = ROOT+"/rooms/"
    static let USERINFO = ROOT+"/users/info/"
    static let FAVORITE = ROOT+"/favorites"
    
    static let POPUPROOT = "https://dry-eyrie-61502.herokuapp.com"
    static let EMERGENCY = POPUPROOT+"/popup/emergency"
    static let UPDATE = POPUPROOT+"/popup/update"
    static let FORCE = POPUPROOT+"/popup/update/force"
    static let NOTICE = POPUPROOT+"/popup/notice"
    
    
}
