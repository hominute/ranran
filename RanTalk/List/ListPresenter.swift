//
//  ChatPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/15/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import ObjectMapper


class ListPresenter {
    
    private var userApi = UserAPI()
    
    private var listView : ListView?
    
    let uds = UserDefaults.standard
    
    var isInviting = false
    
    func attachlistView(view : ListView) {
        
        self.listView = view
    }
    
    func detachView() {
        
        self.listView = nil
    }
    
    func getTitle(){
        
        
        var name = uds.string(forKey: "name")
        if name == nil {
            
            name = "AppTest"
        }
        self.listView?.setTitle(title: name!)
    }
    
    func logout(){
        
        
        uds.removeObject(forKey: "userId")
        uds.removeObject(forKey: "name")
        
    }
    
    func onList(){
        
        
        
        let loginuserId = uds.integer(forKey: "userId")
        
        
        let request = ListRequest(userId : Int64(loginuserId) , page : 0 , size : 10)
        
        
        
        userApi.onList(request: request) {content in
            
            if content.error == nil {
                
                
                self.listView?.apiCallback(response: content)
                
            }
            else{
                print("get list error")
            }
        }
    }
    
    
    func getInvite(friendId: Int64){
        if isInviting == false {
            let loginuserId = uds.integer(forKey: "userId")
            let request = InviteRequest(friendId: friendId, userId: Int64(loginuserId))
            isInviting = true
            userApi.getInvite(request: request) { (response, error) in
                
                if error == nil {
                    
                    
                    print(response)
                    
                    if response?.error == nil {
                        self.listView?.inviteApiCallback(response: response!)
                        
                        
                    }else{
                
                        self.listView?.displayMessage(message: response?.message as! String)
                    
                        print("getInvite error")
                    }
                    
                    
                    
                }else{
                    
                    print(response?.message)
                    
                }
                self.isInviting = false
            }
        }
    }
    
    
    
    
    
}
