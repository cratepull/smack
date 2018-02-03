//
//  ChatVC.swift
//  smack
//
//  Created by Sebastian Salamanca on 1/22/18.
//  Copyright © 2018 Sebastian Salamanca. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextBox: UITextField!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var typingUserLbl: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    //Variables
    var isTyping = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bindToKeyboard()
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                    
                }
            }
            
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUserLbl.text = "\(names) \(verb) typing a message"
            } else {
                self.typingUserLbl.text = ""
            }
        }

        if AuthService.instance.isLoggedIn {
            
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
    }
    
    @IBAction func sendMsgPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn{
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageTextBox.text else {return}
            
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                
                if success {
                    self.messageTextBox.text = ""
                    self.messageTextBox.resignFirstResponder()
                    SocketService.instance.stopTyping()
                }
            })
        }
    }
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        //guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        if messageTextBox.text == "" {
            isTyping  = false
            sendBtn.isHidden = true
            //SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
            SocketService.instance.stopTyping()
        } else {
            if isTyping == false {
                sendBtn.isHidden = false
                SocketService.instance.startTyping()
                //SocketService.instance.socket.emit("startType:", UserDataService.instance.name, channelId)
            }
            isTyping = true
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedIn {
                onLoginGetMesseges()
        }else{
            channelNameLabel.text = "Plase Log in"
            tableView.reloadData()
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func channelSelected(_ notif: Notification){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        
        channelNameLabel.text = "#\(channelName)"
        
        getMessages()
    }
    
    
    
    func onLoginGetMesseges(){
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                }else{
                    self.channelNameLabel.text = "No channels yet!"
                }
            }
        }
    }
    
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessegesForChannel(channelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
}
