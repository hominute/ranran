//
//  UserListService.swift
//  RanTalk
//
//  Created by KIM HO MIN on 10/12/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

import Foundation

class UserListService {
    
    static func getFriendList(request : UserListRequest , callBack : @escaping  (UserListResponse) -> Void) {
        
        let parameters  : Parameters =  ["userId" : request.userId! , "page" : request.page! , "size" : request.size!]
        
        Alamofire.request(APIConstant.LIST, method: .get , parameters : parameters , encoding : URLEncoding.default, headers: [:]).responseObject {
            (response: DataResponse<UserListResponse>)  in
////
//            let data = response.data
//            let responsedata = String(data: data!, encoding: .utf8)!
//            print("get list responsedata = \(responsedata)")
            
            
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
    
    var useridPath : String?
    
    static func getUserInfo(userId : Int64, callBack : @escaping (UserProfileResponse) -> Void){
        
        let url = APIConstant.USERINFO + "/\(userId)"
        
        Alamofire.request(url, method: .get).responseObject {
            (response: DataResponse<UserProfileResponse>)  in

            switch response.result {
                
            case .success:
                DispatchQueue.main.async {
                    callBack(response.result.value!)
                    
                    print("response = \(response)")
                }
                break
            case .failure(let error):
                print(error)
                print("error")
            }
        }
    }
    
    static func getFavoriteList(userId : Int64 , callBack : @escaping  (UserListResponse) -> Void) {
        
        let url = APIConstant.FAVORITE + "/\(userId)"
        
        Alamofire.request(url, method: .get ).responseObject {
            (response: DataResponse<UserListResponse>)  in
            
//            let data = response.data
//            let responsedata = String(data: data!, encoding: .utf8)!
//            print("get favorite responsedata = \(responsedata)")
            
            
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
    
    
    
    
    
    
    
    
}
