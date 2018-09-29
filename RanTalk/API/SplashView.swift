//
//  UserView.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit


protocol SplashView : NSObjectProtocol {
    
  
    func emergencyCallback(response: SplashResponse)
    func updateCallback(response: SplashResponse)
    func forceCallback(response: SplashResponse)
    func noticeCallback(response: SplashResponse)
    
    
}
