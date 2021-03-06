//
//  UserAPI.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//


import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class UserAPI {
    
   
    
    func onSignIn(request : UserRequest, callBack : @escaping (UserResponse) -> Void){
        
        let parameters  : Parameters =  ["email" : request.email! , "password" : request.password!]
        Alamofire.request(APIConstant.SIGNIN, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: [:]).responseObject {
            (response: DataResponse<UserResponse>)  in
            let data = response.data
//            print("fullresponse = \(fullresponse)")
            let responsedata = String(data: data!, encoding: .utf8)!
            print("full responsedata = \(responsedata)")
            
            switch response.result {
                
            case .success:
                DispatchQueue.main.async {
                    callBack(response.result.value!)
     
                  
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    

    
    func onSignUp(request : UserRequest , callBack : @escaping  (UserResponse) -> Void) {
        
        let parameters  : Parameters =  [ "email" : request.email! ,"name" : request.name! , "password" : request.password!]
        
        Alamofire.request(APIConstant.SIGNUP, method: .post , parameters : parameters , encoding : URLEncoding.default, headers: [:]).responseObject {
            (response: DataResponse<UserResponse>)  in
            
            let data = response.data
            //            print("fullresponse = \(fullresponse)")
            let responsedata = String(data: data!, encoding: .utf8)!
            print("full responsedata = \(responsedata)")
            
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    callBack(response.result.value!)
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
  
    
    func addFavoriteList(request : FavoriteRequest , callBack : @escaping  (FavoriteResponse) -> Void) {
        
        let parameters  : Parameters =  ["userId" : request.userId! , "friendId" : request.friendId! ]
        
        Alamofire.request(APIConstant.FAVORITE, method: .post , parameters : parameters , encoding : URLEncoding.default, headers: [:]).responseObject {
            (response: DataResponse<FavoriteResponse>)  in
            
            let data = response.data
            let responsedata = String(data: data!, encoding: .utf8)!
            print("full responsedata = \(responsedata)")
            
            
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    print("resonse = \(response)")
                    callBack(response.result.value!)
                    
                    
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func deleteFavoriteList(request : FavoriteRequest , callBack : @escaping  (FavoriteResponse) -> Void) {
        
        let parameters  : Parameters =  ["userId" : request.userId! , "friendId" : request.friendId! ]
        
        Alamofire.request(APIConstant.FAVORITE, method: .delete , parameters : parameters , encoding : URLEncoding.default, headers: [:]).responseObject {
            (response: DataResponse<FavoriteResponse>)  in
            
            let data = response.data
            let responsedata = String(data: data!, encoding: .utf8)!
            print("full responsedata = \(responsedata)")
            
            
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    print("resonse = \(response)")
                    callBack(response.result.value!)
                    
                    
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getInvite(request : InviteRequest , callBack : @escaping  (InviteResponse?, Error?) -> Void) {
        
        let parameters  : Parameters =  ["friendId" : request.friendId! , "userId" : request.userId!]
        
        Alamofire.request(APIConstant.INVITE, method: .post , parameters : parameters  , encoding : JSONEncoding.default, headers: [:]).responseObject {
            (response: DataResponse<InviteResponse>)  in
            
            let data = response.data
            let responsedata = String(data: data!, encoding: .utf8)!
            print("full responsedata = \(responsedata)")
            
            
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    callBack(response.result.value!, nil)
                    
                    print("resonse = \(response)")
                }
                break
            case .failure(let error):
                callBack(nil, error)
                print(error)
            }
        }
    }
    
    
    func getRoom(request : RoomRequest , callBack : @escaping  (RoomResponse?, Error?) -> Void) {
        
        let parameters  : Parameters =  ["userId" : request.userId! , "page" : request.page! , "size" : request.size!]
        
        Alamofire.request(APIConstant.ROOM, method: .get , parameters : parameters  , encoding : URLEncoding.default, headers: [:]).responseObject {
            (response: DataResponse<RoomResponse>)  in
            
            let data = response.data
            let responsedata = String(data: data!, encoding: .utf8)!
            print("full responsedata = \(responsedata)")
            
            
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    callBack(response.result.value!, nil)
                    
                    print("resonse = \(response)")
                }
                break
            case .failure(let error):
                callBack(nil, error)
                print(error)
            }
        }
    }
    
    
    func onChat(request : ChatRequest , callBack : @escaping  (ChatResponse) -> Void) {
        
        let parameters  : Parameters =  ["roomId" : request.roomId! , "userId" : request.userId! , "page" : request.page! , "size" : request.size!]
        
        Alamofire.request(APIConstant.CHAT, method: .get , parameters : parameters , encoding : URLEncoding.default, headers: [:]).responseObject {
            (response: DataResponse<ChatResponse>)  in
            
            let data = response.data
            let responsedata = String(data: data!, encoding: .utf8)!
            print("full responsedata = \(responsedata)")
            
            
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    callBack(response.value as! ChatResponse)
                    
                    print("resonse = \(response)")
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func sendChat(request : SendRequest , callBack : @escaping  (SendResponse?, Error?) -> Void) {
        
        let parameters  : Parameters =  ["message" : request.message! , "roomId" : request.roomId! , "userId" : request.userId!]
        
        Alamofire.request(APIConstant.CHAT, method: .post , parameters : parameters  , encoding : JSONEncoding.default, headers: [:]).responseObject {
            (response: DataResponse<SendResponse>)  in
            
            let data = response.data
            let responsedata = String(data: data!, encoding: .utf8)!
            print("full responsedata = \(responsedata)")
            
            
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    callBack(response.result.value!, nil)
                    
                    print("resonse = \(response)")
                }
                break
            case .failure(let error):
                callBack(nil, error)
                print(error)
            }
        }
    }
    
    
    
    
}
