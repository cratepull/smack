//
//  LogInVC.swift
//  smack
//
//  Created by Sebastian Salamanca on 1/22/18.
//  Copyright © 2018 Sebastian Salamanca. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {
    
    // OUtlets
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = usernameTxt.text, usernameTxt.text != "" else { return  }
        guard let pass = passwordTxt.text, passwordTxt.text != "" else { return  }
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        
                        self.spinner.isHidden = true
                        self.spinner.startAnimating()
                        self.dismiss(animated: true, completion: nil)
                    
                    }
                })
            }
        }
    }
    
    func setUpView(){
        
       spinner.isHidden = true
        
        let attrs = [NSForegroundColorAttributeName: smackPurplePlaceholder]
        
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes: attrs)
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attrs)
        
       //let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
       //view.addGestureRecognizer(tap)
    }
    
}
