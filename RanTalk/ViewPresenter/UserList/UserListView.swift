//
//  ListTableViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher


protocol UserListProtocol {
    
    func inviteApiCallback(response: InviteResponse)
    func setTitle(title: String)

    func reloadmyList(data: UserProfileResponse)
    func reloadfriendList(data: UserListResponse)
    func reloadfavoriteList(data: UserListResponse)
}

class UserListView: UITableViewController, InviteProtocol, UserProfileProtocols {

    
    
    
    let heightOfheader : CGFloat = 44
    let presenter = UserListPresenter()
    var roomid = Int64()
    var friendid = Int64()
    var friendList = [UserList]()
    var favoriteList = [UserList]()
    var myList = [UserList]()
    var friendName = String()
    var statusmessage = String()
    
    
    @IBAction func Logout(_ sender: UIStoryboardSegue) {
        
        presenter.logout()
        
    }
    
    
    //Cycle Func Start
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTable()
        presenter.getMyList()
        presenter.attachlistView(view: self)
        
        
        presenter.getTitle()
        presenter.getFriendList()
        presenter.getFavoriteList()
    }
    
    func setupView() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 138, green: 176, blue: 212)
    }
    
    func setupTable() {
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named:"background"))
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
        
        
    }
    
    
    // Cycle Func End
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.font = UIFont.systemFont(ofSize: 13)
            headerView.textLabel?.textColor = .black
            headerView.backgroundView?.backgroundColor = UIColor.rgb(red: 138, green: 176, blue: 212)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if self.favoriteList.count == 0 {
            
            return 2
        }
        
        return 3
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            
            return self.myList.count
        }
        
        if section == 1 {
            if self.favoriteList.count == 0 {
                
                return self.friendList.count
            }
            
            return self.favoriteList.count
            
            
        }else {
            
            return self.friendList.count
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            
            return "나"
        }
        if section == 1 {
            if self.favoriteList.count == 0 {
                
                return "접속한 사람들"
            }
            return "즐겨찾기"

        }else{
            
            return "접속한 사람들"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell

        var friend : UserList?

        if indexPath.section == 0 {
            
            friend = myList[indexPath.row]
     
        }
        
        if indexPath.section >= 1 {
            
            if indexPath.section == 1 {
                
                
                if self.favoriteList.count != 0 {
                    friend = self.favoriteList[indexPath.row]
                }else {
                    
                    if self.friendList.count != 0 {
                    friend = self.friendList[indexPath.row]
                        
                    }
                }
            }else {
                
                if self.friendList.count != 0 {
                    friend = self.friendList[indexPath.row]
                    
                }
            }
            
            
        }
        

        cell.setupCell(userlist: friend!)

        cell.inviteClickDelegate = self
        cell.profilClickDelegate = self
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let cell = tableView.cellForRow(at: indexPath) as! UserTableViewCell
 
        cell.clickProfile()
        

    }
    
    
    // Utility Func
    
    
    func inviteClickCallback(friendId: Int64) {
        
        //        listPresenter.getInvite(friendId: friendId)
        
    }
    
    
    // ViewCallback
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if(segue.identifier == "gochat") {
            
            let chatViewController = (segue.destination as! ChatView)
            chatViewController.roomId = self.roomid
            
            
        }
        
        if(segue.identifier == "logout") {
            presenter.logout()
            
            
        }
        if(segue.identifier == "listtoprofile") {
            
            let userProfileView = (segue.destination as! UserProfileView)
            //            userProfileViewController.myName = "hoho"
            userProfileView.friendName = self.friendName
            userProfileView.statusmessage = self.statusmessage
            userProfileView.friendId = self.friendid
            
    
        }
        
    }
}




extension UserListView : UserListProtocol {
    
    func reloadfriendList(data: UserListResponse) {
        
        friendList = (data.data?.content)!
        tableView.reloadData()
        
    }
    
    func reloadfavoriteList(data: UserListResponse) {
        
        favoriteList = (data.data?.content)!
        tableView.reloadData()
        
    }
    
    func reloadmyList(data: UserProfileResponse) {
    
        myList = [data.data] as! [UserList]
        tableView.reloadData()
    }
    

    
    func inviteApiCallback(response: InviteResponse) {
        
        self.roomid = (response.data?.roomId)!
        self.performSegue(withIdentifier: "gochat", sender: self)
        
        
    }

    
    func setTitle(title: String) {

        navigationItem.title = title
        
    }
    

    
    func profileClickCallback(friendId : Int64, friendName: String, statusmessage: String) {
        ImageCache.default.calculateDiskCacheSize(completion:{ size in
            
            print("imagecache size = \(size)")
        })
        self.friendName = friendName
        self.statusmessage = statusmessage
        self.friendid = friendId
        print("\(self.friendName)")
        print("\(self.statusmessage)")
        performSegue(withIdentifier: "listtoprofile", sender: self)
    }
    

}
