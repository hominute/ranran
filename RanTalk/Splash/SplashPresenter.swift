//
//  UserPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class SplashPresenter {
    
    
    private let splashApi = SplashAPI()
    weak private var splashView : SplashView?
    
    
    
    func attachView(view : SplashView){
        self.splashView = view
    }
    
    
    
    func detachView(){
        self.splashView = nil
    }
    
    
    
    func getEmergency(){
        splashApi.getEmergency() {response in
            
            if response.error == nil {
    
                
//                if user.user != nil {
////                    ShareReferences.shared.setUser(user: user.user!)
//                }
    
                
//                self.userView?.apiCallback(response: user)
                self.splashView?.emergencyCallback(response: response)
                
                
                print("emergenc successful")
            }
            else{
                
                print(response.error?.message)
                
            }
        }
    }
    
    func getUpdate(){
        splashApi.getUpdate() {response in
            
            if response.error == nil {
           
                
//                if user.user != nil {
//                    ShareReferences.shared.setUser(user: user.user!)
//                }

//                self.userView?.apiCallback(response: user)
//                self.userView?.navigation()
                
                self.splashView?.updateCallback(response: response)
                
                print("update successful")
            }
            else{
                
                print(response.error?.message)
                
            }
        }
    }
    
    func getForce(){
        splashApi.getForce() {response in
            
            if response.error == nil {
 
                
//                if user.user != nil {
//                    ShareReferences.shared.setProfile(profile: user.user!)
//                }

                
//                self.userView?.apiCallback(response: user)
//                self.userView?.navigation()
                self.splashView?.forceCallback(response: response)
                
                print("force successful")
            }
            else{
                
                print(response.error?.message)
                
            }
        }
    }
    
    func getNotice(){
        splashApi.getNotice() {response in
            
            if response.error == nil {
         
                
//                if user.user != nil {
//                    ShareReferences.shared.setProfile(profile: user.user!)
//                }
          
                
//                self.userView?.apiCallback(response: user)
//                self.userView?.navigation()
                self.splashView?.noticeCallback(response: response)
                
                print("notice successful")
            }
            else{
                
                print(response.error?.message)
                
            }
        }
    }
    
    

    
}
