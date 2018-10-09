//
//  ChatView.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/15/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//



protocol ChatView {
    func refresh()
    func refreshRange()
    func clearInputTextField()
    func apiCallback(response: ChatResponse)
    func addChat(chat: MessageData)
    func moreMessageCallback(response: ChatResponse)
    func scrollToBottom()
    
}
