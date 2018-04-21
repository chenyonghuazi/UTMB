//
//  settingModel.swift
//  UTMB
//
//  Created by Edwin on 2018/4/16.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import Foundation

class settingModel {
    var title:String
    var id:String = ""
    var content:String = ""
    var phoneNumber:String = ""
    
    init(title:String, id:String, content:String, phoneNumber:String) {
        self.title = title
        self.id = id
        self.content = content
        self.phoneNumber = phoneNumber
    }
}
