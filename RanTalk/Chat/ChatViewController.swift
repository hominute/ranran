//
//  ChatViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import StompClientLib
import CoreGraphics


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ChatView, StompClientLibDelegate{
    
    
    func refresh() {
        
        tableView.reloadData()
        
    }
    
    func clearInputTextField() {
        self.inputTextfield.text = ""
    }
    
    
    var keyboardShown:Bool = false // 키보드 상태 확인
    var originY:CGFloat?
    
    
    func apiCallback(response: BaseResponse) {
        
        let message = (response as! ChatResponse).content
        
        self.list = (message?.reversed())! + self.list
        
        self.tableView.reloadData()
        DispatchQueue.main.async {
            
            
            if (self.page == 0) {
                self.scrollToBottom()
            }
        }
        
        self.success = true
        
    }
    
    let presenter  = ChatPresenter()
    
    var roomId = Int64()
    var userId = Int64(2)
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ChatViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    
    @IBOutlet var fullView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var inputmessageView: UIView!
    @IBOutlet var inputTextfield: UITextField!
    @IBAction func sendButton(_ sender: Any) {
        let chat = SendRequest(message : inputTextfield.text! , roomId : 2 , userId : 2)
        
        presenter.sendChat(request: chat)
        
    }
    
    
    @IBOutlet var sendButtonOL: UIButton!
    
    var socketClient = StompClientLib()
    
    var page = 0
    lazy var success = false
    lazy var list: [MessageData] = {
        var datalist = [MessageData]()
        
        //               datalist.append(MessageData(messageType: "other", userId: 0, message: "this is other message 1 "))
        return datalist
        
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMessage()
        
        registerForKeyboardNotifications()
        
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        presenter.attachChatView(view: self)
        
        let urls = NSURL(string: "wss://dry-eyrie-61502.herokuapp.com/ran-chat/websocket")!
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: urls as URL) , delegate: self as StompClientLibDelegate)
        tableView.dataSource = self
        tableView.delegate = self
        
        inputTextfield.delegate = self
        
        self.tableView.addSubview(self.refreshControl)
        
        self.tabBarController?.tabBar.isHidden = true
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        unregisterForKeyboardNotifications()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter.detachView()
        
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
        
        
        if messageData.chatType == "MY"  {
            
            print("message ==== \(messageData.message)")
            
            return getMyMessageCell(messageData: messageData, indexPath: indexPath)
            
            
        }else{
            
            return getOtherMessageCell(messageData: messageData, indexPath: indexPath)
            
        }
        
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
        cell.message.sizeToFit()
        cell.message.numberOfLines = 0
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //StompClientLib
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, withHeader header: [String : String]?, withDestination destination: String) {
        
        print("Destination : \(destination)")
        print("JSON Body : \(String(describing: jsonBody))")
        
    }
    
    func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        
        print("DESTIONATION : \(destination)")
        print("String JSON BODY : \(String(describing: jsonBody))")
        
        let message = jsonBody
        let data = message?.data(using: String.Encoding.utf8)
        
        
        
        do{
            let messagedatas = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
            
            
            let messageTypes = messagedatas["chatType"] as? String
            
            print("messageType = \(messageTypes!)")
            
            //            let md = MessageData(chatType: messagedatas["chatType"] as? String, userId: messagedatas["userId"] as? Int64, message: messagedatas["message"] as? String)
            var md = MessageData()
            
            md.chatType = messagedatas["chatType"] as? String
            md.userId = messagedatas["userId"] as? Int64
            md.message = messagedatas["message"] as? String
            //
            md.chatType = md.userId == userId ? "MY" : "OTHER"
            //
            self.list.append(md)
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                print("\(self.list.count)")
                self.scrollToBottom()
            }
            
            
            
            
        }catch{
            print("error")
        }
        
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        
        socketClient.subscribe(destination: "/chat/\(2)")
        
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        
    }
    
    func serverDidSendPing() {
        
    }
    
    
    
    //Utility Func
    
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            
            let indexPath = IndexPath(row:self.list.count - 1,section: 0)
            
            if self.list.count != 0 {
                
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
        
    }
    
    
    func getMessage () {
        
        
        
        
        let user = ChatRequest(roomId : 2 , userId : 2 , page : Int64(self.page) , size : 10)
        
        self.presenter.onChat(request: user)
        
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        
        self.page = self.page + 1
        print("current page number = \(self.page)")
        getMessage()
        
        if success == true {
            print("success status= \(success)")
            
            
            refreshControl.endRefreshing()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
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
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardSize.height == 0.0 || keyboardShown == true {
                return
            }
            
            //            UIView.animate(withDuration: 0.33, animations: { () -> Void in
            if originY == nil { originY = fullView.frame.size.height
            }
            fullView.frame.size.height = originY! - keyboardSize.height
            //            }, completion: {
            keyboardShown = true
            scrollToBottom()
            //            })
        }
    }
    
    @objc func keyboardWillHide(note: NSNotification) {
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardShown == false {
                return
            }
            //
            //                UIView.animate(withDuration: 0.33, animations: { () -> Void in
            guard let originY = originY else { return }
            fullView.frame.size.height = originY
            //                }, completion: {
            keyboardShown = false
            //                })
        }
    }
    
    
    
}

