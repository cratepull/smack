//
//  UserDataService.swift
//  smack
//
//  Created by Sebastian Salamanca on 1/24/18.
//  Copyright © 2018 Sebastian Salamanca. All rights reserved.
//

import Foundation


class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var name = ""
    public private(set) var email = ""
    
    
    func setUserData(id: String, color:String, avatarName:String, email:String, name:String){
        
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
        
    }
    
    func setAvatarName(avatarName:String){
        
        self.avatarName = avatarName
    
    }

}
