//
//  SplashViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/22/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController,SplashView {
    func emergencyCallback(response: SplashResponse) {
        //popupdate force 강제업데이트
        
       
        
        self.displayMessage(title: (response.data?.title)!, userMessage: (response.data?.description)!, completion: {
            () -> Void in
            
            self.presenter.getForce()
            
            
        })
        
    }
    
    func updateCallback(response: SplashResponse) {
        //popup notice 공지사항
        
        
        self.displayMessage(title: (response.data?.title)!, userMessage: (response.data?.description)!, completion: {
            () -> Void in
            
            self.presenter.getNotice()
            
            
        })
    }
    
    func forceCallback(response: SplashResponse) {
        //popup update 선택앱업데이트
        
       
        self.displayMessage(title: (response.data?.title)!, userMessage: (response.data?.description)!, completion: {
            () -> Void in
            
            self.presenter.getUpdate()
            
            
        })
    }
    
    func noticeCallback(response: SplashResponse) {
        
        self.displayMessage(title: (response.data?.title)!, userMessage: (response.data?.description)!, completion: {
            () -> Void in
            
            let uds = UserDefaults.standard
            
            let loginId = uds.integer(forKey: "userId")
            
            
            self.performSegue(withIdentifier: "splashSegue", sender: self)
            
            
        })
    }
    

    let presenter  = SplashPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.attachView(view: self)
    //popup emergency 장애
        
        
        presenter.getEmergency()
        
        
    
    
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func displayMessage(title: String, userMessage:String, completion: @escaping () -> Void) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title:title, message: userMessage, preferredStyle:.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    
                    print("Ok button tapped")
                    
                    completion()
                  
                }
                
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                
                
        }
    }

}
