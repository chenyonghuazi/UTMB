//
//  HomeNearbySellCell.swift
//  UTMB
//
//  Created by Edwin on 2018/2/18.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit

class HomeNearbySellCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var cellBookImage: UIImageView!
    @IBOutlet weak var cellProfile: UIImageView!
    @IBOutlet weak var cellUserName: UILabel!
    @IBOutlet weak var cellBookTitle: UILabel!
    @IBOutlet weak var cellMessage: UILabel!
    @IBOutlet weak var cellPrice: UILabel!
    @IBOutlet weak var cellDistance: UILabel!
    

}
