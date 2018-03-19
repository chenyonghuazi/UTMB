//
//  Data.swift
//  UTMB
//
//  Created by Edwin on 2018/3/13.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import Foundation
import Firebase

extension bookList{
    
    func observing(){
        let index = tapped_course_code!.index((tapped_course_code?.startIndex)!, offsetBy: 2)
        let program = tapped_course_code![...index]
        ref?.child("course").child(String(program)).observe(.childAdded, with: { (snapshot) in
            print("snapshotHere",snapshot)
            if snapshot.value != nil && snapshot.key == self.tapped_course_code!{
                if let dic = snapshot.value as? [String:String]{
                    for (key,value) in dic{
                        self.booklist[key] = value
                    }
                    print("***",self.booklist)
                }
                self.tableV.reloadData()
            }
            self.tableV.reloadData()
        })
        
    }
    
}
