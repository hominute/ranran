//
//  ChatPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/15/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import ObjectMapper
import StompClientLib

class ChatPresenter: StompClientLibDelegate {
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        
    }
    
    func serverDidSendPing() {
        
    }
    
    
    
    private var userApi = UserAPI()
    
    private var view : ChatView?
    
    let uds = UserDefaults.standard
    var page = 0
    let size = 24
    var roomId: Int64?
    var totalpages : Int64?
    var totalMessages : Int64?
    
    var isLoading = false
    
    var socketClient = StompClientLib()
    
    init() {
        
    }
    
    init(roomId: Int64) {
        self.roomId = roomId
    }
    
    
    func attachChatView(view : ChatView) {
        
        self.view = view
    }
    
    func detachView() {
        self.socketClient.disconnect()
        self.view = nil
    }
    
  
    
    func getMessage() {
        if isLoading == false {
            self.isLoading = true
            let loginuserId = uds.integer(forKey: "userId")
            
            let user = ChatRequest(roomId : roomId! , userId : Int64(loginuserId) , page : Int64(self.page) , size : Int64(self.size))
            
            userApi.onChat(request: user) { response in
                
                
                
                print("content = \(response.data?.content?.toJSON())")
                
                print("message =-------- asaasdsd\(response.data?.content)")
                
                if response.error == nil {
                    
            
                    if self.page == 0 {
                        self.view?.apiCallback(response: response)
                        self.view?.refresh()
                        self.socketConnect()
                        self.view?.scrollToBottom()
                        
                    } else {
                        self.view?.moreMessageCallback(response: response)
                        self.view?.refreshRange()
                    }
                    
                }
                
                self.isLoading = false
            }
        }
        
    }
    
    func getMessageMore() {
        if isLoading == false {
            
            self.page = self.page + 1
            print("current page number = \(self.page)")
            self.getMessage()
            // self.chatView.fetchMode = false
        }
    }
    
    
    
    func sendChat(roomId: Int64?, chat: String?){
        do{
            let roomIds = roomId
            let userId = uds.integer(forKey: "userId")
            let chat = ["message" : chat! , "roomId" : roomId! , "userId" : userId] as [String : Any]
            self.socketClient.sendJSONForDict(dict: chat as AnyObject, toDestination: "/publish/chats")
            self.view?.clearInputTextField()
            
            print("roomId = \(roomIds!)")
            print("userId = \(userId)")
            print("message = \(chat)")
        }
    }
    
    func socketConnect(){
        
        let urls = NSURL(string: "wss://dry-eyrie-61502.herokuapp.com/ran-chat/websocket")!
        self.socketClient.openSocketWithURLRequest(request: NSURLRequest(url: urls as URL) , delegate: self as StompClientLibDelegate)
        
    }
    
    //StompClientLib
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, withHeader header: [String : String]?, withDestination destination: String) {
        print("============")
        print("Destination : \(destination)")
        print("JSON Body : \(String(describing: jsonBody))")
        print("============")
        
    }
    
    func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        
        print("DESTIONATION : \(destination)")
        print("String JSON BODY : \(String(describing: jsonBody))")
        
        let message = jsonBody
        let data = message?.data(using: String.Encoding.utf8)
        print("socket message = \(data)")
        
        
        do{
            let messagedatas = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
            
            
            let md = MessageData()
            
            
            md.userId = messagedatas["userId"] as? Int64
            md.message = messagedatas["message"] as? String
            let tmpDate = messagedatas["createdDate"] as? AnyObject
//            md.createdDate = "\(tmpDate)"
//            print("\(tmpDate)")
            
            
            if tmpDate != nil {
                
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                dateFormatter.locale = Locale(identifier: "ko")
                let date = dateFormatter.date(from: tmpDate as! String)
                if let date = date {
                    
                    dateFormatter.dateStyle = .none
                    dateFormatter.timeStyle = .short
                    let finaldate = dateFormatter.string(from: date)
                    
                    md.createdDate = "\(finaldate)"
                    
                }
                
            }
            
            
            
            
            
            
            
            
            md.photo = messagedatas["photo"] as? String
            
            let uds = UserDefaults.standard
            
            let loginuserId = uds.integer(forKey: "userId")
            //
            md.chatType = md.userId == Int64(loginuserId) ? "MY" : "OTHER"
            //
            
            self.view?.addChat(chat: md)
            
            
        }catch{
            print("error")
        }
        
    }
    
    
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("WebSocket is disconnected")
        
        let loginuserId = uds.integer(forKey: "userId")
        
        self.socketConnect()
        
        
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        
        self.socketClient.subscribe(destination: "/subscribe/chats/\(self.roomId!)")
        print("selfroomid = \(self.roomId!)")
        
    }
    
}
