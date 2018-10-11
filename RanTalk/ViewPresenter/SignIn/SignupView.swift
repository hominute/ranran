//
//  SignupViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit


protocol SignupProtocol {
    
    func startLoading()
    func stopLoading()
    func navigation()
    func signUpSuccessful(message : String)
    func errorOccurred(message : String)
    func apiCallback()
    func apiCallback(response: UserResponse)
    
    
}


class SignupView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,  UIPickerViewDelegate, UIPickerViewDataSource{

    
    var sexOption = ["남자","여자"]
    var pickerView = UIPickerView()
    @IBOutlet var signupView: UIView!
    
    let presenter  = SignupPresenter()
    
    
    @IBAction func userPhoto(_ sender: Any) {
        
         handlePlusPhoto()

    }
    
    @IBOutlet var userPhotoOL: UIButton!
    
    @IBOutlet var regName: UITextField!
    
    @IBOutlet var regEmail: UITextField!
    
    @IBOutlet var regPass: UITextField!
    
    @IBOutlet var regrePass: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet var sex: UITextField!
    
    @IBAction func signUp(_ sender: Any) {
        
        
        if  (regName.text?.isEmpty)! ||
            (regEmail.text?.isEmpty)! ||
            (regEmail.text?.isEmpty)!
            
        {
            self.displayMessage(message: "다채워 쫌 ㅂㅅ아")
            return
        }
        
        if ((regPass.text?.elementsEqual(regrePass.text!))! != true)
        {
            self.displayMessage(message: "암호가 일치하지 않습니다.")
            return
        }
        
        let user = UserRequest(name : regName.text!, email : regEmail.text!  , password : regPass.text!)
        
        presenter.onSignUp(request: user)
        
        
    }
    @objc func donebuttonpressed (){
        
        print("donebuttonpressed")
    }
    
    @objc func cancelbuttonpressed (){
        
        print("cancelbuttonpressed")
    }
    
    /// Cycle Func
    override func viewDidLoad() {
        super.viewDidLoad()
        sex.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
    
        
        
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
    
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(donebuttonpressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(cancelbuttonpressed))
       
        let testlabel = UILabel()
        testlabel.text = "성별"
         let labelbutton = UIBarButtonItem(customView: testlabel)
        toolBar.setItems([cancelButton,spaceButton ,labelbutton,spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        sex.inputAccessoryView = toolBar
        
        
        
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
    //Picker View delegate
   
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sexOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sexOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sex.text = sexOption[row]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
  
    //Picker View delegate end
    
  
    

    
    
    
    
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


extension SignupView : SignupProtocol{
    
    
    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
    
    func navigation() {
        
    }
    
    func signUpSuccessful(message: String) {
        
    }
    
    func errorOccurred(message: String) {
        
    }
    
    func apiCallback() {
        
    }
    
    func apiCallback(response: UserResponse) {
        
        
        
    }
    
}
