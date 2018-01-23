//
//  ChannelVC.swift
//  smack
//
//  Created by Sebastian Salamanca on 1/22/18.
//  Copyright © 2018 Sebastian Salamanca. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){}

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
}
