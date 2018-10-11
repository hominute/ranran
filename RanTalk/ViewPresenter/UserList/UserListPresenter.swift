//
//  ChatPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/15/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import ObjectMapper


class UserListPresenter {

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
    
    func getFriendList(){

        let loginuserId = uds.integer(forKey: "userId")
        
        
        let request = UserListRequest(userId : Int64(loginuserId) , page : 0 , size : 10)
        
        
        
        UserListService.getFriendList(request: request) {data in
            
            if data.error == nil {
                
                self.view?.reloadfriendList(data: data)
                
            }
            else{
                print("get friend list error")
            }
        }
    }
    
    func getFavoriteList(){
        
        
        let loginuserId = uds.integer(forKey: "userId")

        
        UserListService.getFavoriteList(userId : Int64(loginuserId) ) {data in
        
            if data.error == nil {
                
                
                self.view?.reloadfavoriteList(data: data)
                
            }
            else{
                print("get favorite list error")
            }
        }
        
        
    }
    
    func getMyList(){
        
        
        let loginuserId = UserDefaults.loginedId
        
        UserListService.getUserInfo(userId : Int64(loginuserId) ) {data in
            
            if data.error == nil {
                
                self.view?.reloadmyList(data: data)

                
            }
            else{
                print("get list error")
            }
        }
        
        
    }
    
//    func getInvite(friendId: Int64){
//        if isInviting == false {
//            let loginuserId = uds.integer(forKey: "userId")
//            let request = InviteRequest(friendId: Int64(friendId), userId: Int64(loginuserId))
//            isInviting = true
//            UserListService.getInvite(request: request) { (response, error) in
//                
//                if error == nil {
//                    
//                    
//                    print(response)
//                    
//                    if response?.error != nil {
//                        self.view?.inviteApiCallback(response: response!)
//                        
//                        
//                    }else{
//                
//                        self.view?.displayMessage(message: response?.error?.message as! String)
//                    
//                        print("getInvite error")
//                    }
//                    
//                    
//                    
//                }else{
//                    
//                    print(response?.error?.message)
//                    
//                }
//                self.isInviting = false
//            }
//        }
//    }
    
    
    
    
    
}
