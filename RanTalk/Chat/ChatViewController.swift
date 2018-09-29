//
//  ChatViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//
import Foundation
import UIKit
import CoreGraphics
import CoreImage
import SwiftyJSON


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UITextFieldDelegate, ChatView, UserinfoProtocol{
    
    
    
    var cellHeightsDictionary: [IndexPath: CGFloat] = [:]
    var presenter : ChatPresenter?
    var keyboardShown:Bool = false // 키보드 상태 확인
    var originY:CGFloat?
    
    
    var roomId = Int64()
    
    var activeTextFieldRect: CGRect?
    var activeTextFieldOrigin: CGPoint?
    
    var firstrow : Int?
    var firstsection : Int?
    
    var lastrow : Int?
    var lastsection : Int?
    var list = [MessageData]() // todo set
    var indexPath: IndexPath?
    
    
    
    func UserinfoCallback(userId: Int64) {
        self.performSegue(withIdentifier: "chatfriendinfo", sender: self)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "chatfriendinfo") {
            
            
            let uvcc = (segue.destination as! ProfileViewController)
            
            
        }
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var firstrow = self.tableView.indexPathsForVisibleRows?.first?.row
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        print("offsetY = \(offsetY)")
        print("first visiblerow = \(firstrow)")
        if self.list.count != 0 {
            if firstrow! == 4 {
                beginBatchFetch()
                
            }
        }
        
    }
    
    
    func beginBatchFetch(){
        print("beginBatchfetch")
        presenter?.getMessageMore()
    }
    
    
    
    @IBAction func tableUp(_ sender: Any) {
        
    }
    
    
    @IBAction func tableDown(_ sender: Any) {
        
    }
    
    
    
    
    @IBOutlet var fullView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var inputmessageView: UIView!
    @IBOutlet var inputTextfield: UITextField!
    @IBAction func sendButton(_ sender: Any) {
        
        if inputTextfield.text! != "" {
            
            presenter?.sendChat(roomId: self.roomId, chat: inputTextfield.text!)
            
        }
    }
    
    
    @IBOutlet var sendButtonOL: UIButton!
    
    
    
    // Cycle Func
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotifications()
        
        self.tabBarController?.tabBar.isHidden = true
        presenter = ChatPresenter(roomId: self.roomId)
        presenter?.attachChatView(view: self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        presenter?.getMessage()
    }
    
    
    var visibleindexPath : IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.hideKeyboardWhenTappedAround(view: tableView)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        inputTextfield.delegate = self
        
      
        
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        unregisterForKeyboardNotifications()
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter?.detachView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    //TableView DelegateFunc
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageData = list[indexPath.row]
        //        self.indexPath = indexPath
        
        if messageData.chatType == "MY"  {
            
            
            
            return getMyMessageCell(messageData: messageData, indexPath: indexPath)
            
            
        }else{
            
            return getOtherMessageCell(messageData: messageData, indexPath: indexPath)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.cellHeightsDictionary[indexPath] = cell.frame.size.height
    }
    
    
    func getMyMessageCell (messageData: MessageData, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.layer.borderWidth = 0
        cell.layer.borderColor = UIColor.clear.cgColor
        
        cell.message.layer.cornerRadius = cell.message.frame.size.height / 5
        //        cell.message.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cell.message.layer.masksToBounds = true
        cell.message.text = messageData.message
        cell.createdDate.text = messageData.createdDate
        cell.message.sizeToFit()
        cell.message.numberOfLines = 0
        
        
        return cell
        
    }
    
    
    func getOtherMessageCell (messageData: MessageData, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherTableViewCell", for: indexPath) as! OtherTableViewCell
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.layer.borderWidth = 0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.message.layer.cornerRadius = cell.message.frame.size.height / 5
        cell.message.layer.masksToBounds = true
        cell.message.text = messageData.message!
        if messageData.createdDate != nil {
            cell.createdDate.text = messageData.createdDate
        }
        cell.message.sizeToFit()
        cell.message.numberOfLines = 0
        cell.delegte = self
        if let imageUrl = messageData.photo {
            
            
            cell.imageLoad(url: imageUrl)
        }
        //        cell.friendImage.sizeToFit()
        cell.friendImage.layer.cornerRadius = cell.friendImage.frame.size.height / 2
        cell.friendImage.layer.masksToBounds = true
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let height = self.cellHeightsDictionary[indexPath] {
            return height
        }
        
        return UITableViewAutomaticDimension
    }
    
    
    //Utility Func
  
    
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            
            let indexPath = IndexPath(row:self.list.count - 1,section: 0)
            
            if self.list.count != 0 {
                
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                
            }
        }
        return
    }
    
    
    // TextField Delegate Func
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("Should begin editing")
        self.inputTextfield = textField
        return true;
    }
    
    
    
    /// Notification Observer
    
    func registerForKeyboardNotifications() {
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }
    
    func unregisterForKeyboardNotifications() {
        // 옵저버 등록 해제
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }
    
    
    
    @objc func keyboardWillShow(note: NSNotification) {
        
        let duration = note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardSize.height == 0.0 || keyboardShown == true {
                
                return
            }
            
            print("keyboard show duration = \(duration)")
            
            if originY == nil { originY = fullView.frame.size.height
                
            }
            
            UIView.animate(withDuration: duration , animations: {
                self.view.layoutIfNeeded()
                self.fullView.frame.size.height = self.originY! - keyboardSize.height
            }, completion: {
                (value: Bool) in
                self.keyboardShown = true
            })
            
            
            self.lastrow = self.tableView.indexPathsForVisibleRows?.last?.row
            self.lastsection = self.tableView.indexPathsForVisibleRows?.last?.section
            
            
            /// dispatchqueue test end
            
            if self.list.count != 0 {
                self.scrollToVisibleBottom()
                
            }
        }
        
        
    }
    
    
    
    func scrollToVisibleBottom () {
        
        if self.list.count != 0 {
            DispatchQueue.main.async{
                

                let visibleindexPath = IndexPath(row: self.lastrow!, section: self.lastsection!)
                
                print(visibleindexPath)
                
                
                UIView.animate(withDuration: 0.25 , animations: {
                    
                    self.view.layoutIfNeeded()
                    self.tableView.scrollToRow(at: visibleindexPath, at: .bottom, animated: true)
                    
                }, completion: {
                    (value: Bool) in
                    
                })
                
            }
        }
    }
    
    
    
    @objc func keyboardWillHide(note: NSNotification) {
        let duration = note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardShown == false {
                return
            }
            self.lastrow = self.tableView.indexPathsForVisibleRows?.last?.row
            self.lastsection = self.tableView.indexPathsForVisibleRows?.last?.section
            guard let originY = originY else { return }
            
            
            UIView.animate(withDuration: duration , animations: {
                self.fullView.frame.size.height = originY
                self.view.layoutIfNeeded()
                
            }, completion: {
                (value: Bool) in
                self.keyboardShown = false
            })
            
            
            
            
            if self.list.count != 0 {
                scrollToVisibleBottom ()
                
            }
            
        }
    }
    
    // API Callback Func
    
    
    func clearInputTextField() {
        self.inputTextfield.text = ""
    }
    
    func apiCallback(response: BaseResponse) {
        
        let message = (response as! ChatResponse).data?.content
        
        print("current list count = \(self.list.count)")
        DispatchQueue.main.async {
            
            
            if message != nil {
                self.list = (message?.reversed())! + self.list
                
            }
            
            
        }
    }
    
    func refresh() {
        self.tableView.reloadData()
    }
    
    func refreshRange(){
        self.tableView.reloadData()
//        var indexPaths = [IndexPath(row: 0...10 , section: 0)]()
//        var count = 0
//        while(count < 10) {
//            var indexPath = IndexPath()
//            indexPath.row = count
//            indexPaths.append(indexPath)
//            count = count + 1
//        }
//
//        self.tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.none)
    }
    
    
    func addChat(chat: MessageData) {
        self.list.append(chat)
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
            print("\(self.list.count)")
            
            
        }
        if chat.chatType == "MY"{
            self.scrollToBottom()
        }
    }
    
}

