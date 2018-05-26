//
//  User.swift
//  UTMB
//
//  Created by Edwin on 2018/5/25.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import Foundation

class User {
    var email:String?
    var phone:String?
    var portrait:String?
    
    init(email:String, phone:String?, portrait:String?) {
        self.email = email
        self.phone = phone
        self.portrait = portrait
    }
    
}
