//
//  SignupViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    
    @IBAction func userPhoto(_ sender: Any) {
        
         handlePlusPhoto()

    }
    
    @IBOutlet var userPhotoOL: UIButton!
    
    @IBOutlet var regName: UITextField!
    
    @IBOutlet var regEmail: UITextField!
    
    @IBOutlet var regPass: UITextField!
    
    @IBOutlet var regrePass: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    
    
    @IBAction func signUp(_ sender: Any) {
        
        
        if  (regName.text?.isEmpty)! ||
            (regEmail.text?.isEmpty)! ||
            (regEmail.text?.isEmpty)!
            
        {
            displayMessage(userMessage: "All field are quired to fill in")
            return
        }
        
        if ((regPass.text?.elementsEqual(regrePass.text!))! != true)
        {
            displayMessage(userMessage: "암호가 일치하지 않습니다.")
            return
        }
        
        let postString = "email=\(regEmail.text! as String)&name=\(regName.text! as String)&password=\(regPass.text! as String)"
        
        
        let url = "https://dry-eyrie-61502.herokuapp.com/users/signup"
        
        
        FirstApi.instance().makeAPICall(url: url, params: postString, method: .POST, success: {(data, response, error, responsedata) in
            
            
            // API call is Successfull
            
            let respondata = responsedata
            
            //                DispatchQueue.main.async {
            
            
            if ((respondata.contains("message"))) {
                
                MyDTO().DTO(type: "message", repondata: respondata, userdatas: { (userdatad) in
                    
                    let errormessage = userdatad
                    print("\(errormessage)")
                    self.displayMessage(userMessage: "\(errormessage)")
                    
                }
                )
                
            } else {
                
                
                DispatchQueue.main.async {
                    
                    self.navigationController?.popToRootViewController(animated: true)
                    
                    
                }
                
                
            }
            
            return
            
        }, failure: {(data, response, error) in
            
            self.displayMessage(userMessage: "disconnected")
            
            
            
        }
            
        )
        
        
    }
    
    
/// Cycle Func
    override func viewDidLoad() {
        super.viewDidLoad()

        self.regEmail.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        self.regName.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        self.regPass.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        self.regrePass.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        
        let mycolor = UIColor.gray
        
        userPhotoOL.layer.masksToBounds = true
        userPhotoOL.layer.cornerRadius = 100/2
        userPhotoOL.layer.borderWidth = 1
        userPhotoOL.layer.borderColor = mycolor.cgColor
        
        
        
    }

///Cycle Func End
    
    
    
    
//Utility Func
    
    
    func handlePlusPhoto() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            userPhotoOL.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            userPhotoOL.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
     
        dismiss(animated: true, completion: nil)
    }
    

    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title:"Alert", message: userMessage, preferredStyle:.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            //                            self.dismiss(animated: true, completion: nil)
                    }
                }
                
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)

        }
    }
    
    
    @objc func handleTextInputChange(){
        
        let isEmailValid = regEmail.text?.count ?? 0 > 0 &&
            regName.text?.count ?? 0 > 0 &&
            regPass.text?.count ?? 0 > 0 &&
            regrePass.text?.count ?? 0 > 0
        
        if isEmailValid {
            
            signUpButton.backgroundColor = .red
        } else {
            
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 284, blue: 244)
        }
        
    }
    
    
    
//Utility Func End


}
