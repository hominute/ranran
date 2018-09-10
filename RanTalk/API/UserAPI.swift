//
//  UserAPI.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class UserAPI: UIViewController {
    
    
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
    
    
}
