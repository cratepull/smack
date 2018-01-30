//
//  ChatVC.swift
//  smack
//
//  Created by Sebastian Salamanca on 1/22/18.
//  Copyright © 2018 Sebastian Salamanca. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    
    
    @IBOutlet weak var messageTextBox: UITextField!
    @IBOutlet weak var channelNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bindToKeyboard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
        
        
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
            
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.name, channelId: channelId, completion: { (success) in
                
                if success {
                    self.messageTextBox.text = ""
                    self.messageTextBox.resignFirstResponder()
                
                }
            })
        
        }
        
        
        
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedIn {
                onLoginGetMesseges()
        }else{
            channelNameLabel.text = "Plase Log in"
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
            
        }
    }
}
