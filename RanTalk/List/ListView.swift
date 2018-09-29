//
//  ListView.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/30/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import Foundation

protocol ListView {

    func apiCallback(response: BaseResponse)
    func inviteApiCallback(response: InviteResponse)
    func setTitle(title: String)
    func displayMessage(message: String)
}
