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


class UserListTableViewController: UITableViewController, InviteProtocol, UserProfileProtocol ,UserListView{

    

    

    
    
    let heightOfheader : CGFloat = 44
    let listPresenter = UserListPresenter()
    var roomid = Int64()
    var friendid = Int64()
    var list = [List]()
    var favoriteList = [List]()
    var myList = [List]()
    var friendName = String()
    var statusmessage = String()
    
    
    @IBAction func Logout(_ sender: UIStoryboardSegue) {
        
        listPresenter.logout()
        
    }
    
    
    //Cycle Func Start
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        listPresenter.attachlistView(view: self)
        self.navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 138, green: 176, blue: 212)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named:"background"))
        
        
        listPresenter.getTitle()
        listPresenter.onList()
        listPresenter.getFavoriteList()
        listPresenter.getMyList()
    }
    
    
    // Cycle Func End
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if self.favoriteList.count == 0 {
            
            return 2
        }else {
            
            return 3
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            
            return self.myList.count
        }
        if section == 1 {
            if self.favoriteList.count == 0 {
                
                return self.list.count
            }else {
                
        return self.favoriteList.count
                
            }
        }else {
        return self.list.count
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.font = UIFont.systemFont(ofSize: 13)
            headerView.textLabel?.textColor = .black
            headerView.backgroundView?.backgroundColor = UIColor.rgb(red: 138, green: 176, blue: 212)
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
                return "찜목록"
            
            
            
        }else{
            return "접속한 사람들"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("current indexpath = \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        
        var friend : List?
        
        if indexPath.section == 0 {
        
            friend = myList[indexPath.row]
        }
        if indexPath.section == 1 {
            
            if self.favoriteList.count == 0 {
                friend = self.list[indexPath.row]
            }else {
                  friend = self.favoriteList[indexPath.row]
                
            }
            
            
        } else {
            
            friend = self.list[indexPath.row]
        }
        
        
        // todo extract
        cell.userName.text = friend?.name
        cell.friendId = (friend?.id)!
//        cell.friendName = (friend?.name)!
        cell.shortMessage.text = friend?.statusMessge
        
        cell.imageLoad(imageUrl: friend?.photo)
        
        cell.inviteClickDelegate = self
        cell.profilClickDelegate = self
        cell.friendName = friend?.name ?? ""
        cell.statusmessage = friend?.statusMessge ?? "-"
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let row = indexPath.row
        
        let cell = tableView.cellForRow(at: indexPath) as! UserTableViewCell
        

        
        cell.clickProfile()
       

        
    }


    // Utility Func
    
    func displayMessage(message:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title:"Alert", message: message, preferredStyle:.alert)
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
        
//        listPresenter.getInvite(friendId: friendId)
       
    }
    
    
    // ViewCallback
    
    func inviteApiCallback(response: InviteResponse) {
        
        self.roomid = (response.data?.roomId)!
        self.performSegue(withIdentifier: "gochat", sender: self)

        
    }
  
    
    func apiCallback(response: BaseResponse) {
        
        let List = (response as! UserListResponse).data?.content
        if List != nil {
        self.list = List!
        self.tableView.reloadData()
            
        }
        
    }
    
    func setTitle(title: String) {
        
        
        navigationItem.title = title
        
    }
    
    func favoriteApiCallback(response: UserListResponse) {
        
        
        let favoriteList = response.data?.content
        if favoriteList != nil {
            
            self.favoriteList = favoriteList!
            self.tableView.reloadData()
        }
        
    }
    
    func profileClickCallback(friendName: String, statusmessage: String) {
        ImageCache.default.calculateDiskCacheSize(completion:{ size in
            
            print("imagecache size = \(size)")
        })
        self.friendName = friendName
        self.statusmessage = statusmessage
        print("\(self.friendName)")
        print("\(self.statusmessage)")
        performSegue(withIdentifier: "listtoprofile", sender: self)
    }
    
    func mylistApiCallback(response: UserProfileResponse) {
        
        let myList = response.data
        
        if myList != nil {
            
            self.myList = [myList!]
            self.tableView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if(segue.identifier == "gochat") {
            
            let chatViewController = (segue.destination as! ChatViewController)
            chatViewController.roomId = self.roomid
                
            
        }
        
        if(segue.identifier == "logout") {
            listPresenter.logout()
            
            
        }
        if(segue.identifier == "listtoprofile") {
            
            let userProfileViewController = (segue.destination as! UserProfileViewController)
//            userProfileViewController.myName = "hoho"
            userProfileViewController.friendName = self.friendName
            userProfileViewController.statusmessage = self.statusmessage
            
//            userProfileViewController.profileImage.
            
        }
        
    }
}


