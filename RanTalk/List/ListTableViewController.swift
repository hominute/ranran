//
//  ListTableViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import Alamofire


class ListTableViewController: UITableViewController, InviteProtocol, UserView{
    func apiCallback(response: BaseResponse) {
        
    }
    
    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
    
    func navigation() {
        
    }
    
    func signInSuccessful(message: String) {
        
    }
    
    func signUpSuccessful(message: String) {
        
    }
    
    func errorOccurred(message: String) {
        
    }
    
    func apiCallback() {
        
        let List = ShareReferences.shared.getList()
        
        self.list = List
        self.tableView.reloadData()
        
        
    }
    

    let heightOfheader : CGFloat = 44
    
    
    let presenter  = UserPresenter(userApi : UserAPI() )
    
    lazy var list: [List] = {
        var datalist = [List]()
        
        
        return datalist
        
    }()
    
    //Cycle Func Start
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         self.tableView.reloadData()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        getList()
        
        let uds = UserDefaults.standard
        
        let name = uds.string(forKey: "name")
        if name != nil {
            navigationItem.title = name
        }
        
        
        
    }
   
    
    func inviteCallback(roomId: Int64) {
        print("yoooooooong")
//        DispatchQueue.main.async {
//
//        }
        self.performSegue(withIdentifier: "gochat", sender: self)
        
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: "hohoho") as! ChatViewController
        
        uvc.roomId = roomId
//        self.navigationController?.performSegue(withIdentifier: "gochat", sender: self)
        
    
//        self.navigationController?.pushViewController(uvc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            let url = "https://dry-eyrie-61502.herokuapp.com/users/?page=0&size=20&userId=\(2)"
        presenter.attachView(view: self)
        tableView.reloadData()
//        FirstApi.instance().makeAPICall(url: url, params:"", method: .GET, success: { (data, response, error, responsedata) in
//            
//            //             API call is Successfull
//            
//            guard let data = data else {
//                print("request failed \(error)")
//                return
//            }
//            
//            do {
//                
//                let apidata = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
//                
//                
//
//                let content = apidata["content"] as? NSArray
//                //                let images = content!["image"] as! NSArray
//                
//                for row in content! {
//                    
//                    
//                    let r = row as! NSDictionary
//                    
//                    let md = MyData()
//                    
////                    md.ID = r["content"] as? String
//                    
////                    md.ID = r["id"] as? String
//                    md.Photo = r["photo"] as? String
//                    md.Nickname = r["name"] as? String
//                    md.userId = r["id"] as? Int64
//                    
//                    
//                    print("\(self.list.count)")
//                    self.list.append(md)
//                    
//                    
//                    DispatchQueue.main.async {
//                        
//                        self.tableView.reloadData()
//                        
//                    }
//                }
//            }
//            catch  {
//            }
//            print("API call is Successfull")
//            
//        }, failure: { (data, response, error) in 
//            // API call Failure
//            print("fail")
//        } )
//        
        
        
    }
    
    
    
    // Cycle Func End


    // MARK: - Table view data source

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
        
//        let cell2 = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
        let row = self.list[indexPath.row]
        let imageurl = row.photo
       
        cell.userName.text = row.name
        cell.friendId = row.id!
        cell.shortMessage.text = "한줄메시지 공사중"
        cell.delegate = self

        
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
    
    
    func getList() {
        
        
        let user = ListRequest(userId : 2 , page : 0 , size : 10)
        
        self.presenter.onList(request: user)
        
    }

}
