//
//  HomeCategoryCell.swift
//  UTMB
//
//  Created by Edwin on 2018/2/18.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
protocol presentPostSellVCdelegate {
    func presentPostSell(cell:UICollectionViewCell)
}

class HomeCategoryCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    let bookButton = ["Find","Post Sell", "Scan"]
    
    @IBOutlet weak var collectionV: UICollectionView!
    var delegate:presentPostSellVCdelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.isScrollEnabled = false
        // Initialization code
        collectionV.delegate = self
        collectionV.dataSource = self
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
        let image2 = #imageLiteral(resourceName: "FindTextBook")
        let image3 = #imageLiteral(resourceName: "post")
        let image4 = #imageLiteral(resourceName: "scan")
//        cell.imageV.frame.size = image.size
//        cell.cellImageButton.layer.cornerRadius = cell.cellImageButton.frame.height / 2 - 25
//        cell.imageV.layer.cornerRadius = cell.imageV.frame.width / 2
        cell.imageV.clipsToBounds = true
        cell.imageV.contentMode = .scaleAspectFit
//        cell.cellImageButton.setImage(image, for: .normal)
        cell.myLabel.text = bookButton[indexPath.row]
        if indexPath.row == 0{
//            cell.cellImageButton.setImage(image2, for: .normal)
            cell.imageV.image = image2
        }else if indexPath.row == 1{
//            cell.cellImageButton.setImage(image3, for: .normal)
            cell.imageV.image = image3
        }
        else if indexPath.row == 2{
//            cell.cellImageButton.setImage(image4, for: .normal)
            cell.imageV.image = image4
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            print("nothing")
        }else if indexPath.row == 1{
            if Auth.auth().currentUser != nil {
                if let cell = collectionView.cellForItem(at: indexPath) as? HomeCategoryCollectionCell {
                    delegate?.presentPostSell(cell: cell)
                }else{
                    print("nothing")
                }
                
                
            }else{
                print("error?")
            }
        }else if indexPath.row == 2{
            print("nothing")
        }
    }
}
