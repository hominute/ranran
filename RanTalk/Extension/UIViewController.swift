//
//  Extensions.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import CoreGraphics



extension UIViewController {




    
    
    func displayMessageWithClosure(title: String, userMessage:String, completion: @escaping () -> Void) -> Void {
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
    
    func displayMessage(message:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title:"Alert", message: message, preferredStyle:.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            
                    }
                }
                
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                
                
        }
    }
    
    
    func hideKeyboardWhenTappedAround(view : UIView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}




