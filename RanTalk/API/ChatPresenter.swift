//
//  ChatPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/15/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import ObjectMapper

class ChatPresenter {
    
    private let userApi = UserAPI()

    private var chatView : ChatView?
    
    
    func attachChatView(view : ChatView) {
        
        self.chatView = view
    }
   
    func detachView() {
        
        self.chatView = nil
    }
    
    func onChat(request : ChatRequest){
        
        userApi.onChat(request: request) { response in
            
            
            print("content = \(response)")
            
            print("message =-------- asaasdsd\(response.content?.count)")
            
            if response.error == nil {
                self.chatView?.apiCallback(response: response)
                
            }
            
            
        }
    }
    
    
    
    func sendChat(request : SendRequest){
        userApi.sendChat(request: request) {message in
            
            if message.error != "" {
                print(message.message as Any)
                
                
                if message.message != nil {
                    self.chatView?.refresh()
                    self.chatView?.clearInputTextField()
                }
                
                print("signinSuccesfulgogogo")
            }
            else{
                
                print(message.message)
                
            }
        }
    }
    
    
}
