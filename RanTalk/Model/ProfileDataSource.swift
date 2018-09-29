//
//  ProfileDataResource.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/21/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

struct ProfileDataSource {
    
    let uid: String
    let username: String
    let profileImageUrl: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}
