//
//  UserSingleton.swift
//  SnapChatClone
//
//  Created by Joseph Cauley on 11/13/19.
//  Copyright © 2019 Joseph Cauley. All rights reserved.
//

import Foundation

class UserSingleton {
    
    static let SharedUserInfo = UserSingleton()
    
    var email = ""
    var userName = ""
    
    private init() {
        
    }
    
}
