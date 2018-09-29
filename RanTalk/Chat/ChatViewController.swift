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
import SwiftyJSON


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UITextFieldDelegate, ChatView, StompClientLibDelegate, UserinfoProtocol{
    
    
 
    
    func UserinfoCallback(userId: Int64) {
        self.performSegue(withIdentifier: "chatfriendinfo", sender: self)

        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "chatfriendinfo") {
            

            let uvcc = (segue.destination as! ProfileViewController)
            

        }
    }
    
    var fetchingMore = false
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
       let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        print("offsetY = \(offsetY)")
        if self.list.count != 0 {
        if offsetY < 0 {
            
            if !fetchingMore {
                
                beginBatchFetch()
            }
            
        }
        }

    }
    
    
    func beginBatchFetch(){
        
        fetchingMore = true
        print("beginBatchfetch")
        self.page = self.page! + 1
        print("current page number = \(self.page)")
        getMessage()
        
    }


    
    @IBAction func tableUp(_ sender: Any) {

    }
    
  
    @IBAction func tableDown(_ sender: Any) {
       
    }
    
    let presenter  = ChatPresenter()
    var keyboardShown:Bool = false // 키보드 상태 확인
    var originY:CGFloat?
    var totalPages : Int64?

    var roomId = Int64()
    var userId = Int64(2)
    var socketClient = StompClientLib()
    
    var activeTextFieldRect: CGRect?
    var activeTextFieldOrigin: CGPoint?

    var firstrow : Int?
    var firstsection : Int?
    
    var lastrow : Int?
    var lastsection : Int?

    
    @IBOutlet var fullView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var inputmessageView: UIView!
    @IBOutlet var inputTextfield: UITextField!
    @IBAction func sendButton(_ sender: Any) {
        
        let uds = UserDefaults.standard
        
        let loginuserId = uds.integer(forKey: "userId")
        
        
        if inputTextfield.text! != "" {
            let chat = SendRequest(message : inputTextfield.text! , roomId : self.roomId , userId : Int64(loginuserId))
            let testchat = ["message" : chat.message! , "roomId" : chat.roomId! , "userId" : chat.userId!] as [String : Any]
            
            do{
                socketClient.sendJSONForDict(dict: testchat as AnyObject, toDestination: SocketPath.TOPIC+"\(roomId)")
                
            }

        }
        tableView.reloadData()
        inputTextfield.text! = ""
    }
    
    
    @IBOutlet var sendButtonOL: UIButton!
    
  
    
    var page : Int64? = 0
    lazy var success = false
    lazy var list: [MessageData] = {
        var datalist = [MessageData]()
        
        return datalist
        
    }()
    
 
    
    // Cycle Func
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let roomId = self.roomId
        
        
        registerForKeyboardNotifications()
         getMessage()
        self.tabBarController?.tabBar.isHidden = true
        
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
//        https://dry-eyrie-61502.herokuapp.com
        self.hideKeyboardWhenTappedAround(view: tableView)
       
        
        tableView.dataSource = self
        tableView.delegate = self
        
        inputTextfield.delegate = self
        
        self.tableView.addSubview(self.refreshControl)
        

    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        unregisterForKeyboardNotifications()

        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter.detachView()
        socketClient.disconnect()
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
    
    //StompClientLib
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, withHeader header: [String : String]?, withDestination destination: String) {
        print("============")
        print("Destination : \(destination)")
        print("JSON Body : \(String(describing: jsonBody))")
        print("============")
        
    }
    
    func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        
        print("DESTIONATION : \(destination)")
        print("String JSON BODY : \(String(describing: jsonBody))")
        
        let message = jsonBody
        let data = message?.data(using: String.Encoding.utf8)
        print("socket message = \(data)")
        
        
        do{
            let messagedatas = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
            

            let md = MessageData()
            

            md.userId = messagedatas["userId"] as? Int64
            md.message = messagedatas["message"] as? String
            let tmpDate = messagedatas["createdDate"] as? AnyObject
            md.createdDate = "\(tmpDate)"
            md.photo = messagedatas["photo"] as? String
            
            let uds = UserDefaults.standard
            
            let loginuserId = uds.integer(forKey: "userId")
            //
            md.chatType = md.userId == Int64(loginuserId) ? "MY" : "OTHER"
            //
            self.list.append(md)
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                print("\(self.list.count)")
                
                
            }
            if md.chatType == "MY"{
                self.scrollToBottom()
            }
            
            
            
        }catch{
            print("error")
        }
        
    }
 
    
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("WebSocket is disconnected")
        let uds = UserDefaults.standard
        
        let loginuserId = uds.integer(forKey: "userId")
        
      
            
           self.socketConnect()

        
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        
        socketClient.subscribe(destination: SocketPath.TOPIC+"\(self.roomId)")
        
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        
    }
    
    func serverDidSendPing() {
        
        
        print("Server did send ping")
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
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        
        self.page = self.page! + 1
        print("current page number = \(self.page)")
        getMessage()
        
        if success == true {
            print("success status= \(success)")
            
            
            
            
        }
        
    }
    
    
   @objc func scrollToBottom(){
        
        DispatchQueue.main.async {
            
            let indexPath = IndexPath(row:self.list.count - 1,section: 0)
            
            if self.list.count != 0 {
                
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                
            }
        }
        return
    }
    
    
    func getMessage () {
        
        let uds = UserDefaults.standard
        
        let loginuserId = uds.integer(forKey: "userId")
        
        
        if loginuserId != 0 {
//            let roomId = self.roomId
            let user = ChatRequest(roomId : roomId , userId : Int64(loginuserId) , page : self.page! , size : 24)
        
        self.presenter.onChat(request: user)
        }else {
            let user = ChatRequest(roomId : 2 , userId : 2 , page : self.page! , size : 24)
            
            self.presenter.onChat(request: user)
            
        }
        
        
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
            
            
//            var haha = self.tableView.indexPathsForVisibleRows?.last
            
            let visibleindexPath = IndexPath(row: self.lastrow!, section: self.lastsection!)
            
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
    }
    
    
    func scrollToVisibleTop () {
        
        if self.list.count != 0 {
            DispatchQueue.main.async{
                
                
                //            var haha = self.tableView.indexPathsForVisibleRows?.last
                
                let visibleindexPath = IndexPath(row: self.firstrow!, section: self.firstsection!)
                
                print(visibleindexPath)
                
                
                UIView.animate(withDuration: 0.25 , animations: {
                    
                    self.view.layoutIfNeeded()
                    self.tableView.scrollToRow(at: visibleindexPath, at: .top, animated: true)
                    
                }, completion: {
                    (value: Bool) in
                    
                })
                
                
                print("scroll to visible bottom success")
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
    
    func refresh() {
        
        if self.page != nil {
            
            if self.page != 0 {
                let contentOffset = self.tableView.contentOffset
                self.tableView.reloadData()
                self.tableView.layoutIfNeeded()

                
            }
        }

        
    }
    
    func clearInputTextField() {
        self.inputTextfield.text = ""
    }
    var indexPath: IndexPath?
    
    var totalElements : Int64?
    func apiCallback(response: BaseResponse) {
    
        
        
        let message = (response as! ChatResponse).data?.content
        self.totalPages = (response as! ChatResponse).data?.totalPages
        self.totalElements = (response as! ChatResponse).data?.totalElements
        print("totalpage = \(self.totalPages)")
        print("totlaElements = \(self.totalElements)")
        
        
       
        print("current list count = \(self.list.count)")
        DispatchQueue.main.async {
            
            
            if (self.page == 0) {
                if message != nil {
                    self.list = (message?.reversed())! + self.list
                    
                }
                self.tableView.reloadData()
                self.socketConnect()
              
                self.scrollToBottom()
//                self.success = true
            }
            
            if (self.page! > 0){
                self.success = true
                
                if message != nil {
                    self.list = (message?.reversed())! + self.list
                    
                }
                self.fetchingMore = false
                
      
                
                }

        }
        
        
        
    }

    func socketConnect(){
        
        let urls = NSURL(string: "wss://dry-eyrie-61502.herokuapp.com/ran-chat/websocket")!
        self.socketClient.openSocketWithURLRequest(request: NSURLRequest(url: urls as URL) , delegate: self as StompClientLibDelegate)
        
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
   var cellHeightsDictionary: [IndexPath: CGFloat] = [:]
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.cellHeightsDictionary[indexPath] = cell.frame.size.height
    }
    

}

