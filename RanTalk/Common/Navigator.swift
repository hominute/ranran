//
//  Navigator.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/10/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class Navigator: NSObject {
    
    static func onMoveToSignUp(view : UIViewController){
        let vc: UIViewController? = view.storyboard?.instantiateViewController(withIdentifier: "viewSignUp")
        if let aVc = vc {
            view.navigationController?.pushViewController(aVc, animated: true)
        }
        else{
            print("Error")
        }
    }
    
    
    static func onMoveToSignIn(view : UIViewController){
        let vc: UIViewController? = view.storyboard?.instantiateViewController(withIdentifier: "viewSignIn")
        if let aVc = vc {
            view.navigationController?.pushViewController(aVc, animated: true)
        }
    }

    
    static func onMoveToList(view : UITableViewController){
        let vc: UITableViewController? = view.storyboard?.instantiateViewController(withIdentifier: "ListTable") as! ChatListView
        if let aVc = vc {
            view.navigationController?.pushViewController(aVc, animated: true)
        }
    }
    

    static func onMoveToSignUpV(view : UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc: UIViewController? = storyboard.instantiateViewController(withIdentifier: "viewSignUp")
        if let aVc = vc {
            view.present(aVc, animated: true, completion: nil)
        }
        else{
            print("Error")
        }
    }
    
    
}
