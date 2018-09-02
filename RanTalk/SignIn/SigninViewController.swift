//
//  ViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 8/31/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {

    @IBAction func testButton(_ sender: Any) {
        self.performSegue(withIdentifier: "logined", sender: self)
        
    }
    @IBOutlet var signinId: UITextField!
    
    @IBOutlet var signinPassword: UITextField!
    
    
    @IBAction func signin(_ sender: Any) {
        
        
        if (signinId.text?.isEmpty)! {
            
            displayMessage(userMessage: "아이디를 입력하세요")
            
            return
            
        } else if (signinPassword.text?.isEmpty)! {
            
            displayMessage(userMessage: "암호를 입력하세요")
            
            return
            
        }else {
            
            
            let url = "https://dry-eyrie-61502.herokuapp.com/users/login"
            
            let postString = "email=\(signinId.text!)&password=\(signinPassword.text!)"
            
            FirstApi.instance().makeAPICall(url: url, params:postString, method: .POST, success: { (data, response, error, responsedata) in
                
                // API call is Successfull
                
                let respondata = responsedata
                
                if ((respondata.contains("message"))) {
                    
                    MyDTO().DTO(type: "message", repondata: respondata, userdatas: { (userdatad) in
                        
                        let errormessage = userdatad
                        print("\(errormessage)")
                        self.displayMessage(userMessage: "\(errormessage)")
                        
                        
                    }
                    )
                    
                } else {
                    
                    
                    DispatchQueue.main.async {
                        
                        
                        
                        
                        MyDTO().DTO(type: "email",repondata: respondata, userdatas: { (userdatad) in
                            
                            let useremail = userdatad
                            print("\(useremail)")
                            
                            
                            let IDdata = UserDefaults.standard
                            IDdata.set(useremail, forKey: "logined")
                            
                            //                                self.presentingViewController?.dismiss(animated:true, completion: nil)
                            
                        }
                            
                        )
                        
                        MyDTO().DTO(type: "id",repondata: respondata, userdatas: { (userdatad) in
                            
                            let userId = userdatad
                            print("userId = \(userId)")
                            
                            
                            let IDdata = UserDefaults.standard
                            IDdata.set(userId, forKey: "userId")
                            
                            //                                self.presentingViewController?.dismiss(animated:true, completion: nil)
                            
                        }
                            
                        )
                        
                        
                        
                        
                        MyDTO().DTO(type: "name",repondata: respondata, userdatas: { (userdatad) in
                            
                            let username = userdatad
                            print("\(username)")
                            
                            
                            let IDdatas = UserDefaults.standard
                            IDdatas.set(username, forKey: "name")
                            //                                self.presentingViewController?.dismiss(animated:true, completion: nil)
                            
                        }
                            
                        )
                        
                        self.performSegue(withIdentifier: "logined", sender: self)
                        
                        
                        
                    }
                    
                }
                
                print("API call is Successfull")
                
            }, failure: { (data, response, error) in
                
                
                // API call Failure
                print("fail")
            } )
        }
        
    }
    
    
    @IBAction func signup(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayMessage(userMessage:String) -> Void {
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

