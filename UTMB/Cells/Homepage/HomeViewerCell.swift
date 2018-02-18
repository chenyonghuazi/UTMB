//
//  HomeViewerCell.swift
//  UTMB
//
//  Created by Edwin on 2018/2/18.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit

class HomeViewerCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellScrollView.contentSize = CGSize(width: cellScrollView.frame.width * 3, height: self.frame.height)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var cellScrollView: UIScrollView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellPager: UIPageControl!
    
}
