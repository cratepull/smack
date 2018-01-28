//
//  addChannelVC.swift
//  smack
//
//  Created by Sebastian Salamanca on 1/28/18.
//  Copyright © 2018 Sebastian Salamanca. All rights reserved.
//

import UIKit

class addChannelVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        
    }
    
    func setUpView(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        bgView.addGestureRecognizer(tap)
        
        let attrs = [NSForegroundColorAttributeName: smackPurplePlaceholder]
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "Name", attributes: attrs)
        descriptionTxt.attributedPlaceholder = NSAttributedString(string: "Description", attributes: attrs)
    }
    
    @objc func handleTap( _ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    

   
}
