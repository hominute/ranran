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
            
            self.displayMessage(message: "아이디를 입력하세요")
            
            return
            
        } else if (signinPassword.text?.isEmpty)! {
            
            self.displayMessage(message: "암호를 입력하세요")
            
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
        
       

    }
    func navigation() {
        
        self.performSegue(withIdentifier: "logined", sender: self)
        
    }
    
    

    
    func errorOccurred(message: String) {
        print(message)
//        dialog(message: message, error: true)
    }
    

    
    
}


    
    


