//
//  ShareReferences.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class ShareReferences: NSObject {
    
    var user  = User()
    
    
    public class var shared: ShareReferences {
        struct Static {
            static let instance: ShareReferences = ShareReferences()
        }
        return Static.instance
    }
    
    func setUser(user : User){
        self.user = user
    }
    
    func getUser() -> User {
        return self.user
    }
    
    var profile = Profile()
    
    func setProfile(profile : Profile){
        self.profile = profile
    }
    
    func getProfile() -> Profile {
        return self.profile
    }
    
   
    var list = UserList()
    
    func setList (list : UserList){
        
        self.list = list
        
    }
    func getList() -> UserList {
        
        return list
    }

    
}
