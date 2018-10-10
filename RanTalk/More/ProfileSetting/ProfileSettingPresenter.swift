//
//  UserPresenter.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import ObjectMapper

class ProfileSettingPresenter {
    
    
    private let userApi = UserAPI()
    private var view : ProfileSettingView?
    
    var isfavoriting = false
    
    func attachView(view : ProfileSettingView){
        self.view = view
    }
    
    
    func detachView(){
        self.view = nil
    }
    
    

    
    
    
}
