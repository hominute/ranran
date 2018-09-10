//
//  UserPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class UserPresenter: NSObject{
    
    
    
    private let userService : UserAPI
    weak private var userView : UserView?
    
    init(userService : UserAPI) {
        self.userService  = userService
    }
    
    func attachView(view : UserView){
        self.userView = view
    }
    
    func detachView(){
//        self.userView = nil
    }
    
    func onSignIn(request : UserRequest){
        userService.onSignIn(request: request) {user in
//            self?.userView?.stopLoading()
            if user.error != "" {
                print(user.message as Any)
                
                if user.user != nil {
                ShareReferences.shared.setUser(user: user.user!)
                }
                if user.message != nil {
                self.userView?.signInSuccessful(message: user.message!)
                }
                self.userView?.navigation()
//                self?.userView?.errorOccurred(message: user.message!)
                print("signinSuccesfulgogogo")
            }
            else{
                
                print(user.message)
//                self?.userView?.signInSuccessful(message: user.message!)
            }
        }
    }
    
    func onSignUp(request : UserRequest){
        userService.onSignUp(request: request) {user in
//            self?.userView?.stopLoading()
            if user.error != "" {
//                self?.userView?.errorOccurred(message: user.message!)
            }
            else{
//                self?.userView?.signInSuccessful(message: user.message!)
            }
        }
    }
    
}
