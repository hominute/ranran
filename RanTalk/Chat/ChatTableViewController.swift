//
//  ChatTableViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class ChatTableViewController: UITableViewController, ChatView {
    func refresh() {
        
    }
    
    func clearInputTextField() {
        
    }
    
    func apiCallback(response: BaseResponse) {
        let List = (response as! RoomResponse).data?.content
        
        
        self.list = List!
        self.tableView.reloadData()
        
    }
    

     let presenter = ChatPresenter()
    
    
     let heightOfheader : CGFloat = 44
    
    lazy var list: [Room] = {
        var datalist = [Room]()
        
        
        return datalist
        
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachChatView(view: self)
       getList()
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
        
        
        cell.lastMessage.text = "ggg lst"
     
        
        if imageurl != "" as? String {
            cell.userImage?.isHidden = false
            cell.userImage?.layer.borderWidth = 2
            cell.imageLoad(url: imageurl! as String)
            print("rendered image url = \(imageurl!)")
        } else {
            cell.userImage?.isHidden = true
            print("empty image url = \(imageurl!)")
        }
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

 
    
    
    
    func getList() {
        
        
        let roomrequest = RoomRequest(userId: 2, page: 0, size: 10)
        presenter.getRoom(request: roomrequest)
        
    }
    
    

}
