//
//  MyDTO.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation

class MyDTO {
    
    
    struct responseContents: Codable {
        let message: String?
        let name: String?
        let email: String?
        let id: Int64?
        
    }
    

    
    func DTO (type: String, repondata : String, userdatas:@escaping (String)-> Void) {
        
        
        let decoder = JSONDecoder()
        let responsedata = repondata.data(using: .utf8)
        
        
        do {
            
            let userdata = try decoder.decode(responseContents.self, from: responsedata!)
            print("first userdata = \(userdata)")
            
            
            let types = type
            
            if (types.contains("message"))
            {
                let messagedata = "\(userdata.message!) "
                userdatas(messagedata)
            }
            if (types.contains("name")){
                let username = "\(userdata.name!)"
                userdatas(username)
            }
            
            if (types.contains("email")){
                let username = "\(userdata.email!)"
                userdatas(username)
            }
            if (types.contains("id")){
                let userId = userdata.id
//                userdatas(userId)
            }
            
            print("last user data = \(userdata)")
            
        } catch {
            print("error on decode: \(error.localizedDescription)")
        }
        
    }
    
    
}
