//
//  ProfileViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/20/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

protocol ProfileSettingProtocol {
    
    func apiCallback(response: BaseResponse)
    
}


class ProfileSettingView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate{

    

    var userId = Int64()

    let presenter  = ProfileSettingPresenter()
    let titles = ["asdd", "dddddasd", "asd", "dssd", "asdddddddddd"]
    

//
    lazy var userInfo: Profile = {
        var datalist = Profile()
        
        
        return datalist
        
    }()
    
    lazy var mydata: [Profile] = {
        var datalist = [Profile]()
        
        
        return datalist
        
    }()
    
    
    var value = Profile().value
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        
        let user = ProfileRequest(userId: userId)
        
//        presenter.getUserInfo(request: user)
        
//        let uds = UserDefaults.standard
//
//        let loginuserId = uds.integer(forKey: "userId")
//
//        if loginuserId != 0 {
//
//            let user = ProfileRequest(userId: Int64(loginuserId))
//
//            presenter.getUserInfo(request: user)
//
//        }else {
//            let user = ProfileRequest(userId: 2)
//
//            presenter.getUserInfo(request: user)
//
//        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        presenter.attachView(view: self)
      
        self.collectionView.reloadData()
        self.tableView.reloadData()
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var collectionView: UICollectionView!
    
//    @IBOutlet var tableView: UITableView!
    
    
    
    //collectionview delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return 1
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
 
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "photocell", for: indexPath) as! ProfileCollectionViewCell
        
        
//        let row = value[indexPath.row]
        let imageurl = "\(value[4])"
      
        
        if imageurl != "" as? String {
//            cell.userImage?.isHidden = false
//            cell.userImage?.layer.borderWidth = 2
            cell.imageLoad(url: imageurl as String)
            print("rendered image url = \(imageurl)")
        
        }
    
  
        
        
        return cell
    }
    
    
   

    
    /// tableview delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 2
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.titles.count
        } else {
            return 1
        }
        
        
    }
    
    
    
    
    lazy var list: [Message] = {
        var datalist = [Message]()
        
        return datalist
        
    }()
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let result: UITableViewCell
        

        
     
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userinfocell", for: indexPath) as! UserInfoTableViewCell
     
            
            cell.listname.text = userInfo.title[indexPath.row]
         
            if value[indexPath.row].count != 0 {
                cell.value.text = value[indexPath.row] as! String
            }
            //Configure here
            result = cell
        } else {

            //Configure here
            result = getPRCell(indexPath: indexPath)
        }
        
        return result
        
        
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        } else {
            return UITableViewAutomaticDimension
        }
        
        
    }
    
    
    func getUserInfoCell (messageData: String, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userinfocell", for: indexPath) as! UserInfoTableViewCell
    
        
        
        cell.listname.text = messageData
        cell.listname.numberOfLines = 0
        cell.value.text = "not yet"
        
        
        return cell
        
    }
    
    
    func getPRCell (indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "prcell", for: indexPath) as! PRTableViewCell
       
        cell.title.text = "자기소개"
        cell.prTextview.text = "공사중"
        
        
        return cell
        
    }
    
    




}


extension ProfileSettingView : ProfileSettingProtocol {
    
    
    
    func apiCallback(response: BaseResponse) {
        let userinfo = (response as! ProfileResponse).user!
        
        var md = value
        
        md[0] = "\(userinfo.email!)"
        md[1] = "\(userinfo.name!)"
        md[2] = "\(userinfo.point!)"
        if userinfo.statusmessage != nil {
            md[3] = "\(userinfo.statusmessage!)"
        }else {
            
            md[3] = "상태메시지를 입력하세요"
        }
        md[4] = "\(userinfo.photo!)"
        
        self.value = md
        print("uservalue -   \(self.value)")
        tableView.reloadData()
        collectionView.reloadData()
    }
}
