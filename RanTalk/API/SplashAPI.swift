//
//  SplashAPI.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/22/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class SplashAPI {
    
    
    
    func getEmergency( callBack : @escaping (SplashResponse) -> Void){

        Alamofire.request(APIConstant.EMERGENCY, method: .get, headers: [:]).responseObject {
            (response: DataResponse<SplashResponse>)  in
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
                print("error")
            }
        }
    }
    
    func getUpdate( callBack : @escaping (SplashResponse) -> Void){
        
        
      
        Alamofire.request(APIConstant.UPDATE, method: .get, headers: [:]).responseObject {
            (response: DataResponse<SplashResponse>)  in
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
                print("error")
            }
        }
    }
    
    func getForce( callBack : @escaping (SplashResponse) -> Void){
        
        
      
        Alamofire.request(APIConstant.FORCE, method: .get, headers: [:]).responseObject {
            (response: DataResponse<SplashResponse>)  in
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
                print("error")
            }
        }
    }
    
    func getNotice( callBack : @escaping (SplashResponse) -> Void){
        
        
        
        Alamofire.request(APIConstant.NOTICE, method: .get, headers: [:]).responseObject {
            (response: DataResponse<SplashResponse>)  in
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
                print("error")
            }
        }
    }
}
