//
//  ListTableViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import Alamofire


class ListTableViewController: UITableViewController, InviteProtocol, ListView{
    
    let heightOfheader : CGFloat = 44
    let listPresenter = ListPresenter()
    var roomid = Int64()
    var friendid = Int64()
    var list = [List]()
    
    
    
    @IBAction func Logout(_ sender: UIStoryboardSegue) {
        
        listPresenter.logout()
        
    }
    
    
    //Cycle Func Start
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        listPresenter.attachlistView(view: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        listPresenter.getTitle()
        listPresenter.onList()
    }
    
    
    // Cycle Func End
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        
        
        let friend = self.list[indexPath.row]
        
        
        // todo extract
        cell.userName.text = friend.name
        cell.friendId = friend.id!
        cell.shortMessage.text = friend.statusMessge
        cell.imageLoad(url: friend.photo as String)
        
        cell.inviteClickDelegate = self
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    // Utility Func
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title:"Alert", message: userMessage, preferredStyle:.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            
                    }
                }
                
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                
                
        }
    }
    
 
    
    func inviteClickCallback(friendId: Int64) {
        
        listPresenter.getInvite(friendId: friendId)
       
    }
    
    
    // ViewCallback
    
    func inviteApiCallback(response: InviteResponse) {
        
        self.roomid = (response.data?.roomId)!
        self.performSegue(withIdentifier: "gochat", sender: self)

        
    }
  
    
    func apiCallback(response: BaseResponse) {
        
        let List = (response as! ListResponse).data?.content
        
        self.list = List!
        self.tableView.reloadData()
        
    }
    
    func setTitle(title: String) {
        
        
        navigationItem.title = title
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if(segue.identifier == "gochat") {
            
            let chatViewController = (segue.destination as! ChatViewController)
            chatViewController.roomId = self.roomid
            
            
        }
        
    }
}


