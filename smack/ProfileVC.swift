//
//  ProfileVC.swift
//  smack
//
//  Created by Sebastian Salamanca on 1/27/18.
//  Copyright © 2018 Sebastian Salamanca. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    
    // Outlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE , object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    


    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(componenets: UserDataService.instance.avatarColor )
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(self.didReceiveMemoryWarning))
        
        view.addGestureRecognizer(closeTouch)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        
        dismiss(animated: true, completion: nil)
    }
    
}
