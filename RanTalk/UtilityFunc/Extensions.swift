//
//  Extensions.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import CoreGraphics

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}


extension ChatViewController {
    
    //
    // dismiss keyboard를 위해 호출되는 메소드
    // 본 클래스의 viewDidLoad에 아래 두 줄 추가
    // let dismissTap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    // self.view.addGestureRecognizer(dismissTap)
    //
    
    @objc func handleTap() {
        debugPrint("touchesBegan")
        if let af = inputTextfield {
            af.endEditing(true)
            
        }
    }
    
    // 키보드가 떠오를 때 발생하는 이벤트 처리
    @objc func keyboardWillShow(notification: NSNotification) {
        debugPrint("keyboard will show")
        keyboardYN = true
        let userInfo = notification.userInfo!
        rectKeyboard = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        
        // 스크롤이 가능한 경우
        let collectionViewOffset = self.tableView.contentOffset
        let activeFieldOrigin = CGPoint(x:(inputTextfield!.superview?.superview?.frame.origin.x)! - collectionViewOffset.x, y: (inputTextfield!.superview?.superview?.frame.origin.y)! - collectionViewOffset.y)
//         키보드에 가려지는 경우에만 화면을 올린다.
        if rectKeyboard.contains(activeFieldOrigin) {
            self.tableView.contentOffset = CGPoint(x: self.tableView.contentOffset.x, y: self.tableView.contentOffset.y + rectKeyboard.size.height)
        }
        
    }
    
    // 키보드가 사라질 때 발생하는 이벤트 처리
    @objc func keyboardWillHide(notification: NSNotification) {
        debugPrint("keyboard will hide")
        keyboardYN = false
        let userInfo = notification.userInfo!
        rectKeyboard = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        // 스크롤이 가능한 경우
        let collectionViewOffset = self.tableView.contentOffset
        let activeFieldOrigin = CGPoint(x: (inputTextfield!.superview?.superview?.frame.origin.x)! - collectionViewOffset.x, y: (inputTextfield!.superview?.superview?.frame.origin.y)! - collectionViewOffset.y)
        let newRectKeyboard = CGRect(x: rectKeyboard.origin.x, y:  rectKeyboard.origin.y - (rectKeyboard.size.height * 2), width:  rectKeyboard.size.width, height: rectKeyboard.size.height)
        if newRectKeyboard.contains(activeFieldOrigin) {
            self.tableView.contentOffset = CGPoint(x: self.tableView.contentOffset.x, y: self.tableView.contentOffset.y - rectKeyboard.size.height)
        }
        
    }
    
    // 위 두 가지 키보드 이벤트를 이벤트로 등록
    func registerKeyboardEvent() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // 위 두 가지 키보드 이벤트를 이벤트에서 해제
    func unregisterKeyboardEvent() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        inputTextfield = nil
        self.sendButton((Any).self)
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        debugPrint("textFieldDidBeginEditing")
        inputTextfield = textField
    }
}
