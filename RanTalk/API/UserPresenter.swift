//
//  UserPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class UserPresenter {
    
    
    private let userApi : UserAPI
    weak private var userView : UserView?
    
    
    init(userApi : UserAPI) {
        self.userApi  = userApi
    }
    
    func attachView(view : UserView){
        self.userView = view
    }
    
    
    func detachView(){
        self.userView = nil
    }
    
    
    
    func onSignIn(request : UserRequest){
        userApi.onSignIn(request: request) {user in

            if user.error == nil {
                print(user.message as Any)
                
                if user.user != nil {
                ShareReferences.shared.setUser(user: user.user!)
                }
                if user.message != nil {
                self.userView?.signInSuccessful(message: user.message!)
                }
                
                self.userView?.apiCallback(response: user)
                self.userView?.navigation()

                print("signinSuccesfulgogogo")
            }
            else{
                
                print(user.message)

            }
        }
    }
    
    func onSignUp(request : UserRequest){
        userApi.onSignUp(request: request) {user in

            if user.error == nil {
                print(user.message as Any)
                
                if user.user != nil {
                    ShareReferences.shared.setUser(user: user.user!)
                }
                if user.message != nil {
                    self.userView?.signUpSuccessful(message: user.message!)
                }
                
                self.userView?.apiCallback(response: user)
                self.userView?.navigation()
                
                print("signupSuccesfulgogogo")
            }
            else{
                
                print(user.message)
                
            }
        }
    }
    
//    func getUserInfo(request : UserProfileRequest){
//        userApi.getUserInfo(request: request) {user in
//            
//            if user.error == nil {
//                print(user.message as Any)
//
//                self.userView?.apiCallback(response: user)
//                self.userView?.navigation()
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
