//
//  SignupViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UserView{
    
    
    @IBOutlet var signupView: UIView!
    
    let presenter  = UserPresenter(userApi : UserAPI() )
    
    
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
            displayMessage(userMessage: "다채워 쫌 ㅂㅅ아")
            return
        }
        
        if ((regPass.text?.elementsEqual(regrePass.text!))! != true)
        {
            displayMessage(userMessage: "암호가 일치하지 않습니다.")
            return
        }
        
        let user = UserRequest(name : regName.text!, email : regEmail.text!  , password : regPass.text!)
        
        presenter.onSignUp(request: user)
        
        
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
        
    }
    
    func apiCallback(response: BaseResponse) {
        
//        performSegue(withIdentifier: "backtosignin", sender: self)
       
    }
    
    
/// Cycle Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.regEmail.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        self.regName.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        self.regPass.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        self.regrePass.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        presenter.attachView(view: self)
        self.hideKeyboardWhenTappedAround(view: signupView)
        
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
