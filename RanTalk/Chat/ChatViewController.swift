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

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, StompClientLibDelegate{
    
    var keyboardYN = false
    var rectKeyboard: CGRect!
    var roomId = Int64()
    var userId = Int64(2)
    var bottomConstraint: NSLayoutConstraint?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ChatViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var inputmessageView: UIView!
    @IBOutlet var inputTextfield: UITextField!
    @IBAction func sendButton(_ sender: Any) {
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urls = NSURL(string: "wss://dry-eyrie-61502.herokuapp.com/ran-chat/websocket")!
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: urls as URL) , delegate: self as StompClientLibDelegate)
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.addSubview(self.refreshControl)
        tableView.reloadData()
        self.tabBarController?.tabBar.isHidden = true
        registerKeyboardEvent()
        getMessage()
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(dismissTap)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterKeyboardEvent()
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
        
        
        if messageData.messageType == "MY"  {
            
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
        cell.message.text = messageData.message
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
            
            let md = MessageData(messageType: messagedatas["chatType"] as? String, userId: messagedatas["userId"] as? Int64, message: messagedatas["message"] as? String)
            
            
            md.messageType = md.userId == userId ? "MY" : "OTHER"
                
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
            
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            
        }
        
    }
    
    
    func getMessage () {
        
        
        let url = "https://dry-eyrie-61502.herokuapp.com/chats?roomId=2&userId=2&page=\(page)&size=10"
        
        FirstApi.instance().makeAPICall(url: url, params:"", method: .GET, success: { (data, response, error, responsedata) in
            
            //             API call is Successfull
            
            guard let data = data else {
                print("request failed \(error)")
                return
            }
            
            do {
                let apidata = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                let content = apidata["content"] as! NSArray
                
                var messages = [MessageData]()
                
                for row in content {
                    
                    let r = row as! NSDictionary
                    
                    let md = MessageData(messageType: r["chatType"] as? String, userId: r["userId"] as? Int64, message: r["message"] as? String)
                    
                    
                    print("\(self.list.count)")
                    messages.append(md)
                    
                }
                
                self.list = messages + self.list
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    if (self.page == 0) {
                        self.scrollToBottom()
                    }
                }
                self.success = true
            }
            catch  {
                
            }
            print("API call is Successfull")
            
        }, failure: { (data, response, error) in
            
            
            // API call Failure
            print("fail")
        } )
        
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
    
   

}
