//
//  ChatPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/15/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import ObjectMapper
import StompClientLib

class ChatListPresenter {

    
    
    private var userApi = UserAPI()
    
    private var chatListView : ChatListView?
    
    let uds = UserDefaults.standard
    var page = 0
    let size = 24
    var roomId: Int64?
    var totalpages : Int64?
    var totalMessages : Int64?
    
    var isLoading = false

    
    init() {
        
    }
    
    init(roomId: Int64) {
        self.roomId = roomId
    }
    
    
    func attachChatListView(view : ChatListView) {
        
        self.chatListView = view
    }
    
    func detachView() {

        self.chatListView = nil
    }
    
    
    func getRoom(request : RoomRequest){
        userApi.getRoom(request: request) { (response, error) in
            
            if error == nil {
                
                
                print(response)
                
                if response?.error == nil {
                    self.chatListView?.apiCallback(response: response!)
                    self.chatListView?.refresh()
                    
                }
                
                print("signinSuccesfulgogogo")
            }
            else{
                
                print(response?.error?.message)
                
            }
            
        }
    }
    
    
 

    
    
    

    
}
