//
//  HomeViewerCell.swift
//  UTMB
//
//  Created by Edwin on 2018/2/18.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewerCell: UITableViewCell,UIScrollViewDelegate {
    var imageData:[String]?
    let placeimage = #imageLiteral(resourceName: "placeholder2")
    var count = 0
    var timer = Timer()
    var count2 = 0
    var swipeImageAnimationTimer = Timer()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellScrollView.contentSize = CGSize(width: cellScrollView.frame.width * 3, height: cellScrollView.frame.height)
        cellScrollView.isPagingEnabled = true
        cellScrollView.showsHorizontalScrollIndicator = false
        cellScrollView.showsVerticalScrollIndicator = false
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(setTimeInterval), userInfo: nil, repeats: true)
//        cellScrollView.anchor(top: self.topAnchor, leading: self.leftAnchor, bottom: self.bottomAnchor, trailing: self.rightAnchor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var cellScrollView: UIScrollView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellPager: UIPageControl!
    
    func setImage(){
        while count >= 0 && count < imageData!.count && count < 3 {
                let countcgfloat = CGFloat(count)
                let imageV = UIImageView()
                imageV.frame = CGRect(x: cellScrollView.frame.width * countcgfloat, y: 0, width: cellScrollView.frame.width, height: cellScrollView.frame.height)
            let url = URL(string:imageData![count])!
                imageV.sd_setImage(with: url,placeholderImage: placeimage)
                imageV.contentMode = .scaleAspectFill
                imageV.layer.cornerRadius = 3
                imageV.clipsToBounds = true
                cellScrollView.addSubview(imageV)
                count += 1
        }
        count = 0
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = cellScrollView.contentOffset.x / cellScrollView.frame.width
//        cellPager.currentPage = Int(offset)
    }
    
    @objc func setTimeInterval(){
        if count2 < 3 {
            UIView.animate(withDuration: 1.5, animations: {
                self.cellScrollView.contentOffset.x = self.cellScrollView.frame.width * CGFloat(self.count2)
            })
            
            count2 += 1
        }else{
            count2 = 0
        }
        
//        swipeImageAnimationTimer = Timer.scheduledTimer(timeInterval: TimeInterval(Int(cellScrollView.frame.width / 1000)), target: self, selector: #selector(handleSwipe), userInfo: nil, repeats: true)
        
    }
    
//    @objc func handleSwipe(){
//        var animationTimer = 0
//        while count2 < 3 && cellScrollView.contentOffset.x < (cellScrollView.frame.width * CGFloat(count2)) && animationTimer <= 1000{
//            cellScrollView.contentOffset.x += CGFloat(1)
//            animationTimer += 1
//        }
//    }
    
    
}
