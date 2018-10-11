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
    private var view : UserProfileView?
    
    var isfavoriting = false
    
    func attachView(view : UserProfileView){
        self.view = view
    }
    
    
    func detachView(){
        self.view = nil
    }
    
    
    func addFavoriteList(request : FavoriteRequest){
        
        
        if isfavoriting == false  {
            userApi.addFavoriteList(request: request) {user in
            
                if user.error == nil {
                 
    
                    self.view?.favoriteCallback(response: user)
                    self.view?.navigation()
    
                    print("signupSuccesfulgogogo")
                }
                else{
    
                    print(user.error?.message!)
    
                }
                
                
            }
            isfavoriting = true
            
        }
    }
    

    
}
