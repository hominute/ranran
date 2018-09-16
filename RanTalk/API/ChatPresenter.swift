//
//  ChatPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/15/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import ObjectMapper

class ChatPresenter {
    
    private var userApi = UserAPI()

    private var chatView : ChatView?
    

    
    
    
    func attachChatView(view : ChatView) {
        
        self.chatView = view
    }
   
    func detachView() {
        
        self.chatView = nil
    }
    
    
    func getRoom(request : RoomRequest){
        userApi.getRoom(request: request) { (response, error) in
            
            if error == nil {
         
                
              print(response)
     
                if response?.error == nil {
                    self.chatView?.apiCallback(response: response!)
                    self.chatView?.refresh()
                    
                }
                
                print("signinSuccesfulgogogo")
            }
            else{
                
                print(response?.message)
                
            }
            
        }
    }
    
    
    
    func onChat(request : ChatRequest){
        
        userApi.onChat(request: request) { response in
        
            
            print("content = \(response.data?.content?.toJSON())")
            
            print("message =-------- asaasdsd\(response.data?.content?.count)")
            
            if response.error == nil {
                self.chatView?.apiCallback(response: response)
                
            }
            
            
        }
    }
    
    
    
    func sendChat(request : SendRequest){
        userApi.sendChat(request: request) { (message, error) in
            
            if error != nil {
                print(message?.message as Any)
                
                
                if message?.message != nil {
                    self.chatView?.refresh()
                    
                }
                
                print("signinSuccesfulgogogo")
            }
            else{
                
                print(message?.message)
                
            }
            self.chatView?.clearInputTextField()
        }
    }
    
    
}
