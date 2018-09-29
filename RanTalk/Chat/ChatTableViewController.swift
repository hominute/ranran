//
//  ChatTableViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class ChatTableViewController: UITableViewController, ChatView, ChatProtocol {
    func refreshRange() {
        
    }
    
    func addChat(chat: MessageData) {
        
    }
    
    func scrollToBottom() {
        
    }
    
  
    var roomid : Int64?


    
     let presenter = ChatPresenter()
    
    
     let heightOfheader : CGFloat = 44
    
    lazy var list: [Room] = {
        var datalist = [Room]()
        
        
        return datalist
        
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         self.tableView.reloadData()
        presenter.attachChatView(view: self)
        getList()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tableView.reloadData()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        let row = self.list[indexPath.row]
        let imageurl = row.friendInfo?.photo
        
        if let roomids = row.roomId {
        cell.testroomId.text = "\(roomids)"
        }
        
        if let userids = row.friendInfo?.id {
        cell.testuserId.text = "\(userids)"
        }
        cell.lastMessage.text = row.lastchat
        cell.roomId = row.roomId!
        cell.userName.text = row.friendInfo?.name
        cell.delegte = self
    
        if let imageurl = imageurl{
            cell.userImage?.isHidden = false
            cell.userImage?.layer.borderWidth = 2
            cell.imageLoad(url: imageurl as String)
            print("rendered image url = \(imageurl)")
        }
//        else {
//            cell.userImage?.isHidden = true
//            print("empty image url = \(imageurl!)")
//        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

 

    
    func getList() {
        
        let uds = UserDefaults.standard
        
        let loginuserId = uds.integer(forKey: "userId")
        
        if loginuserId != 0 {
        let roomrequest = RoomRequest(userId: Int64(loginuserId), page: 0, size: 10)
            presenter.getRoom(request: roomrequest)
            
        }else {
            
            
        let roomrequest = RoomRequest(userId: 2, page: 0, size: 10)
            presenter.getRoom(request: roomrequest)
        
        }
    }
    
    func inviteApiCallback(response: InviteResponse) {
        
    }
    
    
    func ChatCallback(roomId: Int64) {
        
        self.roomid = roomId
        self.performSegue(withIdentifier: "roomchat", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "roomchat") {
            
            
            let uvcc = (segue.destination as! ChatViewController)
            uvcc.roomId = self.roomid!
            
        }
    }
    
    
    func refresh() {
        
    }
    
    func clearInputTextField() {
        
    }
    
    func apiCallback(response: BaseResponse) {
        let List = (response as! RoomResponse).data?.content
        
        self.list = List!
        
        
        self.tableView.reloadData()
        
    }
   
    

}


