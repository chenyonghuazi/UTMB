//
//  bookList_localData.swift
//  UTMB
//
//  Created by Edwin on 2018/3/19.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import Foundation

extension bookList{
    
    func check_localData(bookName:String) -> Bool{
//        var newLocalBookData:[String:String] = [String:String]()
        if UserDefaults.standard.value(forKey: "localBookData") == nil{
            let newLocalBookData = [String:String]()
            
            UserDefaults.standard.set(newLocalBookData, forKey: "localBookData")
            return false
        }else{
            let newLocalBookData = UserDefaults.standard.value(forKey: "localBookData") as! [String:String]
            if newLocalBookData[bookName] != nil{
                return true
            }else{
                return false
            }
        }
        
    }
    
    func get_localData(bookName:String) -> String{
        guard let warehouse = UserDefaults.standard.value(forKey: "localBookData") as? [String:String] else{return "err"}
        return warehouse[bookName]!
        
    }
    
    func set_localData(bookName:String,fileURL:String){
        if !check_localData(bookName: bookName){
            var newLocalBookData = UserDefaults.standard.value(forKey: "localBookData") as! [String:String]
            newLocalBookData[bookName] = fileURL
            UserDefaults.standard.set(newLocalBookData, forKey: "localBookData")
            print("setted!")
        }
    }
    
    
}
