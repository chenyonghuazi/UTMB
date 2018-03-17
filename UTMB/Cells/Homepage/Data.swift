//
//  Data.swift
//  UTMB
//
//  Created by Edwin on 2018/3/9.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import Foundation
import UIKit

extension HomePageController{
    
    func observering(){
//        var count = 0
        datahandle = dataref?.child("homePage").child("topScrollView").observe(.childAdded, with: { (snapshot) in
            if snapshot.value != nil {
                print(snapshot)
                if let dic = snapshot.value as? [String:String]{
                    self.topScrollViewImageSet.insert(dic["webAddress"]!, at: 0)
                    print(self.topScrollViewImageSet)
                }
//                self.tableV.reloadData()
            }
            self.tableV.reloadData()
        })
    }
}
