//
//  MessageCell.swift
//  smack
//
//  Created by Sebastian Salamanca on 1/29/18.
//  Copyright © 2018 Sebastian Salamanca. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    
    func configureCell(message: Message){
        messageBody.text = message.messege
        userNameLabel.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(componenets: message.userAvatarColor)
     
    }
}
