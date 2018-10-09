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
               
                if user.user != nil {
                ShareReferences.shared.setUser(user: user.user!)
                    
                    self.userView?.signInSuccessful(message: "signin successful")
                    self.userView?.apiCallback(response: user)
                    self.userView?.navigation()
       
                }
  
                print("signinSuccesfulgogogo")
            }
            else{
                if let errormessage = user.error?.message  {
                     print("errormessage = \(errormessage)")
                }
               

            }
        }
    }
    
    func onSignUp(request : UserRequest){
        userApi.onSignUp(request: request) {user in

            if user.error == nil {
              
                
                if user.user != nil {
                    ShareReferences.shared.setUser(user: user.user!)
                }
           
                
                self.userView?.apiCallback(response: user)
                self.userView?.navigation()
                
                print("signupSuccesfulgogogo")
            }
            else{
                
                print(user.error?.message)
                
            }
        }
    }
    

    

    
}
