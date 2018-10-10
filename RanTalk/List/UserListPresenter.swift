//
//  ChatPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/15/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import ObjectMapper


class UserListPresenter {
    
    private var userApi = UserAPI()
    
    private var view : UserListView?
    
    let uds = UserDefaults.standard
    
    var isInviting = false
    
    func attachlistView(view : UserListView) {
        
        self.view = view
    }
    
    func detachView() {
        
        self.view = nil
    }
    
    func getTitle(){
        
        
        var name = uds.string(forKey: "name")
        if name == nil {
            
            name = "AppTest"
        }
        self.view?.setTitle(title: name!)
    }
    
    func logout(){
        
        
        uds.removeObject(forKey: "userId")
        uds.removeObject(forKey: "name")
        
    }
    
    func onList(){
        
        
        
        let loginuserId = uds.integer(forKey: "userId")
        
        
        let request = UserListRequest(userId : Int64(loginuserId) , page : 0 , size : 10)
        
        
        
        userApi.onList(request: request) {content in
            
            if content.error == nil {
                
                
                self.view?.apiCallback(response: content)
                
            }
            else{
                print("get list error")
            }
        }
    }
    
    func getFavoriteList(){
        
        
        let loginuserId = uds.integer(forKey: "userId")

        
        userApi.getFavoriteList(userId : Int64(loginuserId) ) {content in
            
            if content.error == nil {
                
                
                self.view?.favoriteApiCallback(response: content)
                
            }
            else{
                print("get list error")
            }
        }
        
        
    }
    
    func getMyList(){
        
        
        let loginuserId = uds.integer(forKey: "userId")
        
        
        userApi.getUserInfo(userId : Int64(loginuserId) ) {content in
            
            if content.error == nil {
                
                
                self.view?.mylistApiCallback(response: content)
                
            }
            else{
                print("get list error")
            }
        }
        
        
    }
    
    func getInvite(friendId: Int64){
        if isInviting == false {
            let loginuserId = uds.integer(forKey: "userId")
            let request = InviteRequest(friendId: Int64(friendId), userId: Int64(loginuserId))
            isInviting = true
            userApi.getInvite(request: request) { (response, error) in
                
                if error == nil {
                    
                    
                    print(response)
                    
                    if response?.error != nil {
                        self.view?.inviteApiCallback(response: response!)
                        
                        
                    }else{
                
                        self.view?.displayMessage(message: response?.error?.message as! String)
                    
                        print("getInvite error")
                    }
                    
                    
                    
                }else{
                    
                    print(response?.error?.message)
                    
                }
                self.isInviting = false
            }
        }
    }
    
    
    
    
    
}
