//
//  UserPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class SignupPresenter {
    
    
    private var userApi = UserAPI()
    weak private var view : SignupView?
    
    
   
    
    func attachView(view : SignupView){
        self.view = view
    }
    
    
    func detachView(){
        self.view = nil
    }
    
    
    

    
    func onSignUp(request : UserRequest){
        userApi.onSignUp(request: request) {user in
            
            if user.error == nil {
                
                
                if user.user != nil {
                    ShareReferences.shared.setUser(user: user.user!)
                }
                
                
                self.view?.apiCallback(response: user)
                self.view?.navigation()
                
                print("signupSuccesfulgogogo")
            }
            else{
                
                print(user.error?.message)
                
            }
        }
    }
    
    
    
    
    
}
