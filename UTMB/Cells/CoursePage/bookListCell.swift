//
//  bookListCell.swift
//  UTMB
//
//  Created by Edwin on 2018/3/13.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit

class bookListCell: UITableViewCell {

    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookFrontImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
