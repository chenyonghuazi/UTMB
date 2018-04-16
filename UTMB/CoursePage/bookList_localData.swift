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
    
    func checkBookCover(bookName:String) -> Bool{
        if UserDefaults.standard.value(forKey: "CoverImage") == nil{
            let coverImage = [String:String]()
            UserDefaults.standard.set(coverImage, forKey: "CoverImage")
            return false
        }else{
            let coverImageSet = UserDefaults.standard.value(forKey: "CoverImage") as! [String:String]
            if coverImageSet[bookName] != nil{
                return true
            }else{
                return false
            }
        }
    }
    func get_coverImage(bookName:String) -> String{
        
        guard let warehouse = UserDefaults.standard.value(forKey: "CoverImage") as? [String:String] else{return "err"}
        if let data = warehouse[bookName]{
            return data
        }
        else{
            
            return "nil"
        }
        
    }
    func set_coverImage(bookName:String,imageData:String){
        if !checkBookCover(bookName: bookName){
            var newLocalBookData = UserDefaults.standard.value(forKey: "CoverImage") as! [String:String]
            newLocalBookData[bookName] = imageData
            UserDefaults.standard.set(newLocalBookData, forKey: "CoverImage")
            print("setted!")
        }
    }
    
}
