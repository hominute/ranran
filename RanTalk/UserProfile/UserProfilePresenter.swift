//
//  UserPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class UserProfilePresenter {
    
    
    private let userApi = UserAPI()
    private var userProfileView : UserProfileView?
    
    
    
    func attachView(view : UserProfileView){
        self.userProfileView = view
    }
    
    
    func detachView(){
        self.userProfileView = nil
    }
    
    
   
//    func getUserInfo(request : UserProfileRequest){
//        userApi.getUserInfo(request: request) {user in
//        
//            if user.error == nil {
//                print(user.message as Any)
//                
//                self.userProfileView?.apiCallback(response: user)
//                self.userProfileView?.navigation()
//                
//                print("signupSuccesfulgogogo")
//            }
//            else{
//                
//                print(user.message)
//                
//            }
//        }
//    }
    
    
    
}
