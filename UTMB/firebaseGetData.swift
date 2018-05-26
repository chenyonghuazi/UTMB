//
//  firebaseGetData.swift
//  UTMB
//
//  Created by Edwin on 2018/5/25.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import Foundation
import Firebase

//func getUserData(uid:String) -> [String:String]{
//    var database = Database.database().reference()
//    var user = User(email: "", phone: "", portrait: "")
//    database.child("user").child(uid).observe(.value) { (snapshot) in
//        if snapshot.value != nil{
//            
//            if let data = snapshot.value as? [String:String]{
//                
//                for (key,value) in data{
//                    
//                    if key == "phone"{
//                        user.phone = value
//                    }else if key == "portrait"{
//                        user.portrait = value
//                    }
//                }
//                
//            }
//        }
//        
//    }
//    
//    return ["phone":user.phone!,"portrait":user.portrait!]
//}

