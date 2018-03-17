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
    let bookButton = ["Find Textbooks","Post Sell", "Buy Textbooks"]
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.isScrollEnabled = false
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
        return bookButton.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCollectionCell", for: indexPath) as! HomeCategoryCollectionCell
        let image = #imageLiteral(resourceName: "book1")
        
        cell.cellImageButton.frame.size = image.size
        cell.cellImageButton.layer.cornerRadius = cell.cellImageButton.frame.height / 2 - 25
        cell.cellImageButton.clipsToBounds = true
        cell.cellImageButton.contentMode = .scaleAspectFill
        cell.cellImageButton.setImage(image, for: .normal)
        cell.myLabel.text = bookButton[indexPath.row]
        return cell
    }
}
