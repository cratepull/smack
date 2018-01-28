//
//  ChannelVC.swift
//  smack
//
//  Created by Sebastian Salamanca on 1/22/18.
//  Copyright © 2018 Sebastian Salamanca. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){}
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUserInfo()
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            
            // Show prof page
            
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        
        }else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
        
    }
    
    func setUpUserInfo(){
        
        if AuthService.instance.isLoggedIn {
            logBtn.setTitle(UserDataService.instance.name, for: UIControlState.normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(componenets: UserDataService.instance.avatarColor)
        }else{
            logBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
        
    }
    
    
    @objc func userDataDidChange(_ notif: Notification){
        setUpUserInfo()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            
            let channel = MessageService.instance.channels[indexPath.row]
            
            cell.configureCell(channel: channel)
            return cell
        
        }else{
            return UITableViewCell()
        
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
}
