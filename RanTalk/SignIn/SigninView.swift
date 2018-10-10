//
//  ViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 8/31/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper


protocol SigninProtocol {
    
    func startLoading()
    func stopLoading()
    func navigation()
    func signInSuccessful(message : String)
    
    func errorOccurred(message : String)
    func apiCallback()
    func apiCallback(response: UserResponse)
    
    
}



class SigninView: UIViewController {
    let presenter  = SigninPresenter()
    
    @IBOutlet var SigninView: UIView!
    
    @IBAction func unwind(_ sender: UIStoryboardSegue) {
        
        
    }

    @IBAction func testLogout(_ sender: Any) {
        
        let uds = UserDefaults.standard
        
        uds.removeObject(forKey: "userId")
        
        
    }
    
    
    
   
    @IBAction func testButton(_ sender: Any) {
        self.performSegue(withIdentifier: "logined", sender: self)
        
    }
    @IBOutlet var signinId: UITextField!
    
    @IBOutlet var signinPassword: UITextField!
    

//    var delegate: APIProtocol?
    
    @IBAction func signin(_ sender: Any) {
        
        
        if (signinId.text?.isEmpty)! {
            
            displayMessage(userMessage: "아이디를 입력하세요")
            
            return
            
        } else if (signinPassword.text?.isEmpty)! {
            
            displayMessage(userMessage: "암호를 입력하세요")
            
            return
            
        }else {
//
           
            
            
            let user = UserRequest(name : "null" , email : signinId.text! , password : signinPassword.text!)

            presenter.onSignIn(request: user)
            
            

        }
        
    }
    
    
    @IBAction func signup(_ sender: Any) {
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //최후의보류
        let uds = UserDefaults.standard
        
        let loginId = uds.integer(forKey: "userId")
        
        if loginId != 0 {
            self.performSegue(withIdentifier: "autologin", sender: self)
            
            
        }
        
 
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.attachView(view: self)
        self.hideKeyboardWhenTappedAround(view: SigninView)

      
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title:"Alert", message: userMessage, preferredStyle:.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default)
                { (action:UIAlertAction!) in
                    
                    print("Ok button tapped")
                    
                }
                
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                
        }
    }
    
}

extension SigninView : SigninProtocol {
 
    
    func apiCallback(response: UserResponse) {
        
        
       let userdata = ShareReferences.shared.getUser()
        
        let IDdata = UserDefaults.standard
        IDdata.set(userdata.id, forKey: "userId")
        IDdata.set(userdata.name, forKey: "name")
    
        
    }
    
    
    func apiCallback() {
        
    
    }
    
    
    func startLoading() {
//        viewProgress.isHidden = false
    }
    
    func stopLoading() {
//        viewProgress.isHidden = true
    }
    
    func signInSuccessful(message: String) {
        print(message)
        
       
        
//        let uds = UserDefaults.standard
//
//        let name = uds.string(forKey: "name")
//        let emails = uds.string(forKey: "logined")
//        dialog(message: message, error: false)
    }
    func navigation() {
        
        self.performSegue(withIdentifier: "logined", sender: self)
        
    }
    
    

    
    func errorOccurred(message: String) {
        print(message)
//        dialog(message: message, error: true)
    }
    
    func dialog(message : String, error: Bool){
        let uiAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        self.present(uiAlert, animated: true, completion: nil)
        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            if !error {
//                Navigator.onMoveToHome(view: self)
            }
        }))
    }
    
    
}


    
    


