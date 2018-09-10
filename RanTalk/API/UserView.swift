//
//  UserView.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

protocol UserView : NSObjectProtocol {
    
    func startLoading()
    func stopLoading()
//    func navigation()
    func signInSuccessful(message : String)
    func signUpSuccessful(message : String)
    func errorOccurred(message : String)
    
}
