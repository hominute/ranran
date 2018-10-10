//
//  UserPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class SigninPresenter {
    
    
    private var userApi = UserAPI()
    weak private var view : SigninView?
    
    

    
    func attachView(view : SigninView){
        self.view = view
    }
    
    
    func detachView(){
        self.view = nil
    }
    
    
    
    func onSignIn(request : UserRequest){
        userApi.onSignIn(request: request) {user in

            if user.error == nil {
               
                if user.user != nil {
                ShareReferences.shared.setUser(user: user.user!)
                    
                    self.view?.signInSuccessful(message: "signin successful")
                    self.view?.apiCallback(response: user)
                    self.view?.navigation()
       
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
    


    

    
}
