//
//  ChatViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//
import Foundation
import UIKit
import StompClientLib
import CoreGraphics
import CoreImage


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UITextFieldDelegate, ChatView, StompClientLibDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        NSLog("Table view scroll detected at offset: %f", scrollView.contentOffset.y)
    }
   
    
    @IBAction func tableUp(_ sender: Any) {

    }
    
  
    @IBAction func tableDown(_ sender: Any) {
       
    }
    
    let presenter  = ChatPresenter()
    var keyboardShown:Bool = false // 키보드 상태 확인
    var originY:CGFloat?

    
    
    var roomId = Int64()
    var userId = Int64(2)
    
    

    
    @IBOutlet var fullView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var inputmessageView: UIView!
    @IBOutlet var inputTextfield: UITextField!
    @IBAction func sendButton(_ sender: Any) {
        
        
        if inputTextfield.text! != "" {
        let chat = SendRequest(message : inputTextfield.text! , roomId : 2 , userId : 2)
        presenter.sendChat(request: chat)
        }
        
        inputTextfield.text! = ""
    }
    
    
    @IBOutlet var sendButtonOL: UIButton!
    
    var socketClient = StompClientLib()
    
    var page = 0
    lazy var success = false
    lazy var list: [MessageData] = {
        var datalist = [MessageData]()
        
        return datalist
        
    }()
    
    
    
    // Cycle Func
    
    
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
    var visibleindexPath : IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachChatView(view: self)
        tableView.reloadData()
        
        self.hideKeyboardWhenTappedAround(view: tableView)
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
        cell.createdDate.text = messageData.createdDate
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
        print("socket message = \(data)")
        
        
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
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ChatViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    
    
    
   @objc func scrollToBottom(){
        
        DispatchQueue.main.async {
            
            let indexPath = IndexPath(row:self.list.count - 1,section: 0)
            
            if self.list.count != 0 {
                
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
        return
    }
    
    
    func getMessage () {
        
        
        
        
        let user = ChatRequest(roomId : 2 , userId : 2 , page : Int64(self.page) , size : 5)
        
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
//        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func unregisterForKeyboardNotifications() {
        // 옵저버 등록 해제
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }
    
    var activeTextFieldRect: CGRect?
    var activeTextFieldOrigin: CGPoint?
    
    var row : Int?
    var section : Int?
    
    
    
    
    let g = DispatchGroup()
    let q1 = DispatchQueue(label: "kr.swifter.app.queue1")
    let q2 = DispatchQueue(label: "kr.swifter.app.queue2")
//    let q3 = DispatchQueue(label: "kr.swifter.app.queue3")
    

    @objc func keyboardWillShow(note: NSNotification) {
        
        let duration = note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardSize.height == 0.0 || keyboardShown == true {
               
                return
            }
            
            print("keyboard show duration = \(duration)")
            
            //            UIView.animate(withDuration: 0.33, animations: { () -> Void in
            if originY == nil { originY = fullView.frame.size.height
       
            }
            UIView.animate(withDuration: duration , animations: {
                self.view.layoutIfNeeded()
                self.fullView.frame.size.height = self.originY! - keyboardSize.height
            }, completion: {
                (value: Bool) in
                self.keyboardShown = true
            })
            
            
            self.row = self.tableView.indexPathsForVisibleRows?.last?.row
            self.section = self.tableView.indexPathsForVisibleRows?.last?.section
            
           
            
            q1.async(group: g) {
                
                print("queue1 완료")
            }

            
            q2.async(group: g) {
                
                print("queue2 완료")
            }
            
          
            g.notify(queue: DispatchQueue.main) {
              
                print("전체 작업완료")
            }
            
              self.scrollToVisibleBottom()
           
            
            
            let hoho = tableView.visibleCells.last

        }
        
    
    }
    
    
    
    func scrollToVisibleBottom () {
        
        
        DispatchQueue.main.async{
            
            
//            var haha = self.tableView.indexPathsForVisibleRows?.last
            let visibleindexPath = IndexPath(row: self.row!, section: self.section!)
            
            print(visibleindexPath)
           
            
            UIView.animate(withDuration: 0.25 , animations: {
                
                self.view.layoutIfNeeded()
                self.tableView.scrollToRow(at: visibleindexPath, at: .bottom, animated: true)
                
            }, completion: {
                (value: Bool) in
                
            })
            
            
            print("scroll to visible bottom success")
        }
        
    }
    
    
    
    @objc func keyboardWillHide(note: NSNotification) {
        let duration = note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardShown == false {
                return
            }
            self.row = self.tableView.indexPathsForVisibleRows?.last?.row
            self.section = self.tableView.indexPathsForVisibleRows?.last?.section
            guard let originY = originY else { return }
            
            
            UIView.animate(withDuration: duration , animations: {
                self.fullView.frame.size.height = originY
                self.view.layoutIfNeeded()
                
            }, completion: {
                (value: Bool) in
                self.keyboardShown = false
            })
            
            

            let haha = tableView.indexPathsForVisibleRows?.last
            let hoho = tableView.visibleCells.last
            print(haha)
            print(hoho)
            
            scrollToVisibleBottom ()

    
        }
    }
    
    // API Callback Func
    
    func refresh() {
        
        tableView.reloadData()
        
    }
    
    func clearInputTextField() {
        self.inputTextfield.text = ""
    }
    
    
    
    func apiCallback(response: BaseResponse) {
        
        let message = (response as! ChatResponse).data?.content
        
        self.list = (message?.reversed())! + self.list
        
        self.tableView.reloadData()
        DispatchQueue.main.async {
            
            
            if (self.page == 0) {
                self.scrollToBottom()
            }
        }
        
        self.success = true
        
    }
    
    
    
}


