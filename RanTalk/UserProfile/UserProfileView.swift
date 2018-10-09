//
//  ListView.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/30/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation

protocol UserProfileView {
    
    func apiCallback(response: UserProfileResponse)
    func favoriteCallback(response: FavoriteResponse)
    func navigation()
    
}
