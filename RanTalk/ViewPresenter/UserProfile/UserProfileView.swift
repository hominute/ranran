//
//  UserProfileViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 10/3/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

protocol UserProfileProtocol {
    
    func apiCallback(response: UserProfileResponse)
    func favoriteCallback(response: FavoriteResponse)
    func navigation()
    
}

class UserProfileView: UIViewController {
    
    var myProfile = false
    var chatProfile = false
    
    var isfavoriting = false
    let uds = UserDefaults.standard
    
    var presenter : UserProfilePresenter?
    var friendName = ""
    var myName = ""
    var statusmessage = ""
    var favorite = false
    var friendId = Int64()
    
    
    @IBOutlet var chatButtonView: UIView!
    
    @IBOutlet var giftButtonView: UIView!
    
    @IBOutlet var banButtonView: UIView!
    
    @IBOutlet var MyprofileButtonView: UIView!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var userInfo: UILabel!
    @IBOutlet var statusMessage: UILabel!
    
    @IBAction func chat(_ sender: Any) {
        print("chat button tapped")
    }
    
    @IBAction func gift(_ sender: Any) {
        print("gift button tapped")
    }
    
    
    @IBAction func ban(_ sender: Any) {
        print("ban button tapped")
    }
    
    @IBAction func myprofile(_ sender: Any) {
        
        print("myprofile button tapped")
    }
    
    @IBAction func favorite(_ sender: Any) {
        
        if favorite == false {
            let loginId = self.uds.integer(forKey: "userId")
            
            let favoriterequest = FavoriteRequest(userId: Int64(loginId), friendId: friendId)
            presenter?.addFavoriteList(request: favoriterequest)
            
            
            print("favorite true")
            return
        }
        
        if favorite == true {
            let loginId = self.uds.integer(forKey: "userId")
            let favoriterequest = FavoriteRequest(userId: Int64(loginId), friendId: friendId)
            
            
            print("favorite false")
            return
        }
        
        
        
        print("favorite button tapped")
    }
    
    @IBAction func notify(_ sender: Any) {
        print("notify button tapped")
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        print("cancel button tapped")
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func more(_ sender: Any) {
        
        print("more button tapped")
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.attachView(view: self)
        
        
        viewSetup()

        // Do any additional setup after loading the view.
    }
    
    
    func viewSetup() {
        let uds = UserDefaults.standard
        
        let loginId = uds.integer(forKey: "userId")
        
        profileImage.layer.cornerRadius = profileImage.bounds.width * 0.5
        
        self.MyprofileButtonView.isHidden = true
        
        
        if friendId == Int64(loginId) {
            
            self.chatButtonView.isHidden = true
            self.banButtonView.isHidden = true
            self.giftButtonView.isHidden = true
            self.MyprofileButtonView.isHidden = false
        }
     
        if chatProfile == true {
            
            self.chatButtonView.isHidden = true
            self.MyprofileButtonView.isHidden = true
        }
      
        if self.friendName != "" {
            self.userName.text = self.friendName
        }
        if self.myName != "" {
            
            self.userName.text = self.myName
        }
        
        self.statusMessage.text = self.statusmessage
        
    }
    
    
    
}

extension UserProfileView : UserProfileProtocol {
    
    func favoriteCallback(response: FavoriteResponse) {
        
        if response.data == false {
            
            favorite = true
        }else{
            
            favorite = false
        }
        
        
    }
    
    
    func apiCallback(response: UserProfileResponse) {
        
    }
    
    func navigation() {
        
    }
    
    
}
