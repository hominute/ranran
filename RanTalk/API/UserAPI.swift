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
        Alamofire.request(API.SIGNIN, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: [:]).responseObject {
            (response: DataResponse<UserResponse>)  in
            let data = response.data
//            print("fullresponse = \(fullresponse)")
            let responsedata = String(data: data!, encoding: .utf8)!
            print("full responsedata = \(responsedata)")
            
            switch response.result {
                
            case .success:
                DispatchQueue.main.async {
                    callBack(response.result.value!)
     
                    print("response = \(response)")
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func onSignUp(request : UserRequest , callBack : @escaping  (UserResponse) -> Void) {
        
        let parameters  : Parameters =  ["name" : request.name! , "email" : request.email! , "password" : request.password!]
        
        Alamofire.request(API.SIGNUP, method: .post , parameters : parameters , encoding : URLEncoding.default, headers: [:]).responseObject {
            (response: DataResponse<UserResponse>)  in
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
    
    func onList(request : ListRequest , callBack : @escaping  (ListResponse) -> Void) {
        
        let parameters  : Parameters =  ["userId" : request.userId! , "page" : request.page! , "size" : request.size!]
        
        Alamofire.request(API.LIST, method: .get , parameters : parameters , encoding : URLEncoding.default, headers: [:]).responseObject {
            (response: DataResponse<ListResponse>)  in
            
            let data = response.data
            let responsedata = String(data: data!, encoding: .utf8)!
            print("full responsedata = \(responsedata)")
            
            
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    callBack(response.result.value!)
                    
                    print("resonse = \(response)")
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func onChat(request : ChatRequest , callBack : @escaping  (ChatResponse) -> Void) {
        
        let parameters  : Parameters =  ["roomId" : request.roomId! , "userId" : request.userId! , "page" : request.page! , "size" : request.size!]
        
        Alamofire.request(API.CHAT, method: .get , parameters : parameters , encoding : URLEncoding.default, headers: [:]).responseObject {
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
    
    
    func sendChat(request : SendRequest , callBack : @escaping  (SendResponse) -> Void) {
        
        let parameters  : Parameters =  ["message" : request.message! , "roomId" : request.roomId! , "userId" : request.userId!]
        
        Alamofire.request(API.CHAT, method: .post , parameters : parameters  , encoding : JSONEncoding.default, headers: [:]).responseObject {
            (response: DataResponse<SendResponse>)  in
            
            let data = response.data
            let responsedata = String(data: data!, encoding: .utf8)!
            print("full responsedata = \(responsedata)")
            
            
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    callBack(response.result.value!)
                    
                    print("resonse = \(response)")
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
