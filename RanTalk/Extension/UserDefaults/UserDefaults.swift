//
//  UserDefaults.swift
//  RanTalk
//
//  Created by KIM HO MIN on 10/12/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static let loginedId = UserDefaults.standard.integer(forKey: "userId")
}
