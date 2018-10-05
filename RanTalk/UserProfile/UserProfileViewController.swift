//
//  UserProfileViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 10/3/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var friendName = ""
    var myName = ""
    var statusmessage = ""
    
    @IBOutlet var banView: UIView!
    
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
    
    
    @IBAction func favorite(_ sender: Any) {
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
    
    var presenter : UserProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.friendName != "" {
        self.userName.text = self.friendName
        }
        if self.myName != "" {
            
            self.userName.text = self.myName
        }
     
        self.statusMessage.text = self.statusmessage
        
        profileImage.layer.cornerRadius = profileImage.bounds.width * 0.5

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
