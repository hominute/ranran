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
    
    private var view : ChatListView?
    
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
        
        self.view = view
    }
    
    func detachView() {

        self.view = nil
    }
    
    
    func getRoom(request : RoomRequest){
        userApi.getRoom(request: request) { (response, error) in
            
            if error == nil {
                
                
                print(response)
                
                if response?.error == nil {
                    self.view?.apiCallback(response: response!)
                    self.view?.refresh()
                    
                }
                
                print("signinSuccesfulgogogo")
            }
            else{
                
                print(response?.error?.message)
                
            }
            
        }
    }
    
    
 

    
    
    

    
}
