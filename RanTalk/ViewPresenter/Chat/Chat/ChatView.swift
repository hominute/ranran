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

protocol ChatViewProtocol {
    func refresh()
    func refreshRange()
    func clearInputTextField()
    func apiCallback(response: ChatResponse)
    func addChat(chat: Message)
    func moreMessageCallback(response: ChatResponse)
    func scrollToBottom()
    func scrollToVisibleBottom()
    func beginBatchFetch()
    
}



class ChatView: UIViewController, UserinfoProtocol, UserProfileProtocols{
    
    
    func profileClickCallback(friendId: Int64, friendName: String, statusmessage: String) {
        
        self.friendName = friendName
        self.statusmessage = statusmessage
        self.friendId = friendId
        
        print("\(self.friendName)")
        print("\(self.statusmessage)")
        performSegue(withIdentifier: "chattoprofile", sender: self)
        
    }
    var messageToAdd = 24
    
    var friendId = Int64()
    var friendName = String()
    var statusmessage = String()
    
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
    var list = [Message]() // todo set
    var indexPath: IndexPath?
    
    
    
    func UserinfoCallback(userId: Int64) {
        self.performSegue(withIdentifier: "chatfriendinfo", sender: self)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "chatfriendinfo") {
            
            
            let uvcc = (segue.destination as! ProfileSettingView)
            
            
        }
        
        if(segue.identifier == "chattoprofile") {
            
            let userProfileView = (segue.destination as! UserProfileView)
            //            userProfileViewController.myName = "hoho"
            userProfileView.friendName = self.friendName
            userProfileView.statusmessage = self.statusmessage
            userProfileView.friendId = self.friendId
            userProfileView.chatProfile = true
            
            
        }
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
        self.tableView.backgroundView = UIImageView(image: UIImage(named:"background"))
        self.navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 138, green: 176, blue: 212)
        
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
    
    
    
    //Utility Func
    
    
    
    
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
    
    
}

extension ChatView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let height = self.cellHeightsDictionary[indexPath] {
            return height
        }
        
        return UITableViewAutomaticDimension
    }
    
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
    
    
    func getMyMessageCell (messageData: Message, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.layer.borderWidth = 0
        cell.layer.borderColor = UIColor.clear.cgColor
        
        cell.message.layer.cornerRadius = cell.message.frame.size.height / 5
        //        cell.message.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cell.message.layer.masksToBounds = true
        cell.message.text = messageData.message
        if messageData.createdDate != nil {
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let date = dateFormatter.date(from: messageData.createdDate!)
            if let date = date {
                
                dateFormatter.dateStyle = .none
                dateFormatter.timeStyle = .short
                let finaldate = dateFormatter.string(from: date)
                
                cell.createdDate.text = "\(finaldate)"
                
            }
            
        }
        cell.message.sizeToFit()
        cell.message.numberOfLines = 0
        
        
        return cell
        
    }
    
    
    func getOtherMessageCell (messageData: Message, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherTableViewCell", for: indexPath) as! OtherTableViewCell
        
        cell.message.text = messageData.message!
        
        if messageData.createdDate != nil {
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let date = dateFormatter.date(from: messageData.createdDate!)
            if let date = date {
                
                dateFormatter.dateStyle = .none
                dateFormatter.timeStyle = .short
                let finaldate = dateFormatter.string(from: date)
                
                cell.createdDate.text = "\(finaldate)"
                
            }
            
        }
        cell.message.sizeToFit()
        cell.message.numberOfLines = 0
        cell.delegte = self
        cell.profilClickDelegate = self
        cell.friendName = "friend userId = \(messageData.userId!)"
        cell.statusMessage = "공사중샛갹"
        if let imageUrl = messageData.photo {
            
            
            cell.imageLoad(url: imageUrl)
        }
        //        cell.friendImage.sizeToFit()
        
        return cell
        
    }
    
    
}


extension ChatView : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var firstrow = self.tableView.indexPathsForVisibleRows?.first?.row
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        //        print("offsetY = \(offsetY)")
        //        print("first visiblerow = \(firstrow)")
        
        
        if self.list.count != 0 {
            
            
            if self.list.count > 23 {
                
                
                
                if firstrow! == 4 {
                    beginBatchFetch()
                    
                }
                
                
            }
        }
        
    }
}

extension ChatView : UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("Should begin editing")
        self.inputTextfield = textField
        return true;
    }
    
}



extension ChatView : ChatViewProtocol {
    
    
    func clearInputTextField() {
        self.inputTextfield.text = ""
    }
    
    func apiCallback(response: ChatResponse) {
        
        let message = response.data?.content
        
        presenter?.totalpages = response.data?.totalPages
        presenter?.totalMessages = response.data?.totalElements
        
        print("current list count = \(self.list.count)")
        
        
        
        if message != nil {
            self.list = (message?.reversed())! + self.list
            
            
            
        }
        
        
        
    }
    
    func moreMessageCallback(response: ChatResponse) {
        
        let message = response.data?.content
        
        presenter?.totalpages = response.data?.totalPages
        presenter?.totalMessages = response.data?.totalElements
        
        if message != nil {
            self.list = (message?.reversed())! + self.list
            
        }
        
        
        
    }
    
    func refresh() {
        self.tableView.reloadData()
    }
    
    func refreshRange(){
        DispatchQueue.main.async {
            let beforeTableViewContentHeight = self.tableView.contentSize.height
            let beforeTableViewOffset = self.tableView.contentOffset.y
            self.tableView.reloadData()
            self.tableView.layer.layoutIfNeeded()
            let offSet = CGPoint(x: 0, y: -64 + (self.tableView.contentSize.height - beforeTableViewContentHeight))
            self.tableView.contentOffset = offSet
            
            
            print("current contentsize = \(self.tableView.contentSize.height)")
            print("before contenthieght = \(beforeTableViewContentHeight)")
        }
        
        
    }
    
    
    func addChat(chat: Message) {
        self.list.append(chat)
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
            print("\(self.list.count)")
            
            
        }
        if chat.chatType == "MY"{
            self.scrollToBottom()
        }
    }
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            
            let indexPath = IndexPath(row:self.list.count - 1,section: 0)
            
            if self.list.count != 0 {
                
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                
            }
        }
        return
    }
    
    
    func scrollToVisibleBottom() {
        
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
    
    func beginBatchFetch(){
        print("beginBatchfetch")
        presenter?.getMessageMore()
    }
}
