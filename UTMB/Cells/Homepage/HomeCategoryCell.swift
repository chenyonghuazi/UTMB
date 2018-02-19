//
//  HomeCategoryCell.swift
//  UTMB
//
//  Created by Edwin on 2018/2/18.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCategoryCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var collectionView: UICollectionView!
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCollectionCell", for: indexPath) as! HomeCategoryCollectionCell
        cell.cellImageButton.sd_setImage(with: URL(string:"https://firebasestorage.googleapis.com/v0/b/utmb-39117.appspot.com/o/20171223.jpg?alt=media&token=415377c4-7c0a-4f1b-9a58-212c827222e4")!, for: .normal, completed: nil)
        return cell
    }
}
