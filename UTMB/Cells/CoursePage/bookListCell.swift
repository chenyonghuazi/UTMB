//
//  bookListCell.swift
//  UTMB
//
//  Created by Edwin on 2018/3/13.
//  Copyright © 2018年 Edwin. All rights reserved.
//

protocol presentPDFViewDelegate {
    func presentPDFView(cell:UITableViewCell)
    func presentActivityController(view:UIActivityViewController)
    func presentAlertSheet(view:UIAlertController)
    func downloadPDF(cell:UITableViewCell) -> Bool
}



import UIKit

class bookListCell: UITableViewCell {

    var passingBookAddressForPDFView:String?
    var imageAddress:String?
    var bookListCellPDFdelegate:presentPDFViewDelegate?
    var cellindex:Int?
    
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookFrontImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bookFrontImage.contentMode = .scaleAspectFill
        self.bookFrontImage.image = #imageLiteral(resourceName: "placeholder2")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func bookOption(_ sender: UIButton) {
        
        let alertsheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "View textbook", style: .default) { (action) in
//            guard let getData = self.passingBookAddressForPDFView else{ return }

            self.bookListCellPDFdelegate?.presentPDFView(cell: self)
        }
        
        let option2 = UIAlertAction(title: "Share", style: .default) { (action) in
            
            if let coverImage = self.bookFrontImage.image{
                let title = " " + self.bookName.text!
                let url = self.passingBookAddressForPDFView! + title
//                let imageV = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
//                imageV.contentMode = .scaleAspectFill
//                imageV.clipsToBounds = true
//                imageV.image = coverImage
                coverImage.draw(in: CGRect(x: 0, y: 0, width: 150, height: 150))
                let share = UIActivityViewController(activityItems: [title, url,coverImage], applicationActivities: nil)
//                share.popoverPresentationController?.barButtonItem = option2
                self.bookListCellPDFdelegate?.presentActivityController(view: share)
            }
            
        }
        let option3 = UIAlertAction(title: "Copy Link", style: .default) { (action) in
            let clipboard = UIPasteboard.general
            clipboard.string = self.passingBookAddressForPDFView
        }
        let option5 = UIAlertAction(title: "Delete this local book data", style: .default) { (action) in
            let fileManager = FileManager.default
            let myDirectory = NSHomeDirectory() + "/Documents"
            let fileArray = fileManager.subpaths(atPath: myDirectory)
            let index = self.cellindex
            try? fileManager.removeItem(atPath: myDirectory + "/\(self.bookName.text! + "\(index!).pdf")")
            
            
        }
        let option4 = UIAlertAction(title: "Download to local", style: .default) { (action) in
            if (self.bookListCellPDFdelegate?.downloadPDF(cell: self))!{
                option5.isEnabled = true
            }
        }
        
        option5.isEnabled = false
        option5.setValue(UIColor.red, forKey: "titleTextColor")
        alertsheet.view.tintColor = UIColor.black
        alertsheet.addAction(option1)
        alertsheet.addAction(option2)
        alertsheet.addAction(option3)
        alertsheet.addAction(option4)
        alertsheet.addAction(option5)
        alertsheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.bookListCellPDFdelegate?.presentAlertSheet(view: alertsheet)
        
    }
    
}

//extension bookListCell:coverImageDelegate{
//    func setCover(cell: UITableViewCell, image: UIImage) {
//        let target = (cell as! bookListCell)
//        target.
//        target.bookFrontImage.contentMode = .scaleAspectFill
//
//        target.bookFrontImage.image = image
//
//    }

    
    
    
    
    
    
    
//}

