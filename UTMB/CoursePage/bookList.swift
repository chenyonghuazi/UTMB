//
//  bookList.swift
//  UTMB
//
//  Created by Edwin on 2018/3/13.
//  Copyright © 2018年 Edwin. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import Alamofire
import MBProgressHUD
import MessageUI
class bookList: UIViewController {
//    var popOutV:UIView?
//    var pdfAddress:UITextView?
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableV: UITableView!
    
    @IBOutlet weak var popOutView: UIView!
    var ref:DatabaseReference?
    var tapped_course_code:String?
    var booklist = [String:String]()
    var bookWarehouse = [String:String]()
    var bookCoverData = [String:String]()
//    var delegate:setCoverInCourseListDeletegate?
    var storage:StorageReference?
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observing_new()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = Storage.storage().reference()
        popOutView.isHidden = true
//        self.tableV.separatorStyle = .none
        self.tableV.tableFooterView = UIView()
        navigationBar.topItem?.title = tapped_course_code
        ref = Database.database().reference()
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var PDFAddress: UILabel!
    
    @IBOutlet weak var upLoadTitle: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var AddressField: UITextField!
    @IBAction func uploadNoice(_ sender: UIBarButtonItem) {
        popOutView.translatesAutoresizingMaskIntoConstraints = false
        popOutView.anchor(top: self.navigationBar.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: .init(top: self.view.frame.height / 3 - self.navigationBar.frame.height, left: 20, bottom: self.view.frame.height / 3, right: 20))
//        self.view.alpha = 0.5
        popOutView.clipsToBounds = true
        popOutView.dropShadow()
        self.view.bringSubview(toFront: popOutView)
        
        popOutView.isHidden = false
        popOutView.backgroundColor = UIColor.white
        upLoadTitle.translatesAutoresizingMaskIntoConstraints = false
//        upLoadTitle.anchor(top: popOutView.topAnchor, leading: popOutView.leadingAnchor, bottom: AddressField.topAnchor, trailing: popOutView.trailingAnchor, padding: .init(top: 5, left: popOutView.frame.width * (1 / 3), bottom: 5, right: popOutView.frame.width * (1 / 3)))
        PDFAddress.translatesAutoresizingMaskIntoConstraints = false
                PDFAddress.anchor(top: popOutView.topAnchor, leading: popOutView.leadingAnchor, bottom: popOutView.bottomAnchor, trailing: nil, padding: .init(top: 64, left: 5, bottom: 64, right: 0), size: .init(width: 90, height: 50)) //popOutView.frame.height * (3 / 8)
        PDFAddress.text = "PDF URL:"
        AddressField.translatesAutoresizingMaskIntoConstraints = false
        AddressField.anchor(top: PDFAddress.topAnchor, leading: PDFAddress.trailingAnchor, bottom: PDFAddress.bottomAnchor, trailing: popOutView.trailingAnchor, padding: .init(top: 10, left: 5, bottom: 10, right: 5), size: .init(width: 0, height: 0))
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
                submitButton.anchor(top: AddressField.bottomAnchor, leading: AddressField.leadingAnchor, bottom: popOutView.bottomAnchor, trailing: nil, padding: .init(top: 10, left: 0, bottom: 5, right: 0), size: .init(width: 60, height: 0))
        submitButton.setTitle("submit", for: .normal)
        
        upLoadTitle.anchor(top: popOutView.topAnchor, leading: popOutView.leadingAnchor, bottom: AddressField.topAnchor, trailing: popOutView.trailingAnchor, padding: .init(top: 5, left: popOutView.frame.width * (1 / 4), bottom: 5, right: popOutView.frame.width * (1 / 4)))
        
        upLoadTitle.text = "Online PDF Upload"
        
    }
    @IBAction func submit(_ sender: UIButton) {
//        print("check addressField",(self.AddressField.text)!)
        if (self.AddressField.text)! != "" {
            let mailComposeViewController = configureMailController()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailComposeViewController, animated: true, completion: nil)
            }else{
                showMailError()
            }
            
        }else{
            //            dismiss(animated: true, completion: nil)
        }
    }
    
}
extension bookList:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booklist.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "book") as! bookListCell
        cell.selectionStyle = .none
        cell.bookName.text = Array(booklist.keys)[indexPath.row]
        cell.bookNameData = Array(booklist.keys)[indexPath.row]
        cell.passingBookAddressForPDFView = Array(booklist.values)[indexPath.row]
        cell.bookListCellPDFdelegate = self
        cell.cellindex = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }


}

extension bookList:presentPDFViewDelegate{
    func presentActivityController(view: UIActivityViewController) {
        present(view, animated: true, completion: nil)
    }
    
    func presentAlertSheet(view: UIAlertController,cell: UITableViewCell) {
        let bookName = (cell as! bookListCell).bookName.text
        if check_localData(bookName: bookName!){
            view.actions[4].isEnabled = true
        }else{
            view.actions[4].isEnabled = false
        }
        present(view, animated: true, completion: nil)
    }
    
    func presentPDFView(cell: UITableViewCell) {
        let index = self.tableV.indexPath(for: cell)!
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        let destVC = story.instantiateViewController(withIdentifier: "PDFView") as! PDFView
        destVC.cell = cell
        destVC.coverdelegate = self
        let bookName = (cell as! bookListCell).bookName.text!
        print("bookName",bookName + "\(index.row).pdf")
        if check_localData(bookName: bookName)  {
            destVC.fileURL = URL(fileURLWithPath: get_localData(bookName: bookName))
            print("HaveDownloaded")
            present(destVC, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Using Celler Data to View?", message: "No downloaded textbook detected", preferredStyle: .alert)
            let alertAction1 = UIAlertAction(title: "Go", style: .default, handler: { (action) in
                destVC.bookAddress = Array(self.booklist.values)[index.row]
                self.present(destVC, animated: true, completion: nil)
            })
            let alertAction2 = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            alert.addAction(alertAction1)
            alert.addAction(alertAction2)
            print("NoDownloaded")
            present(alert, animated: true, completion: nil)
        }
        
        
        
    }
    
    func downloadPDF(cell: UITableViewCell){
//        self.tableV.indexPath(for: cell)
        let target = (cell as! bookListCell)
        guard let link = target.passingBookAddressForPDFView else{ return}
        guard let index = self.tableV.indexPath(for: cell) else{return}
        guard let bookName = target.bookName.text else{return}
        let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
        hub.mode = MBProgressHUDMode.annularDeterminate
        hub.label.text = "Downloading....."
        var bool:Bool = false
        let destination:DownloadRequest.DownloadFileDestination = {_, _ in
            let documentsURL:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let fileURL = documentsURL.appendingPathComponent(bookName + "\(index.row).pdf")
            print("***fileURl",fileURL)
            return (fileURL,[.removePreviousFile,.createIntermediateDirectories])
        }
        
        Alamofire.download(link, to: destination).downloadProgress { (prog) in
            hub.progress = Float(prog.fractionCompleted)
            }.response { (response) in
                hub.hide(animated: true)
                if response.error == nil, let filePath = response.destinationURL?.path{
                    print("downloaded!",filePath)
                    bool = true
//                    self.bookWarehouse[bookName + "\(index.row).pdf"] = filePath
                    if !self.check_localData(bookName: bookName){
                        print("I am here!")
                        self.set_localData(bookName: bookName, fileURL: filePath)
                    }
//                    let actions = activity.actions[4]
//                    actions.isEnabled = true
                }
        }
//        return bool
    }
    func checkDownload(bookNmae: String) ->Bool{
        return check_localData(bookName:bookNmae)
    }
}

extension bookList:coverImageDelegate{
    func setCover(cell: UITableViewCell, image: UIImage) {
        let index = tableV.indexPath(for: cell)
        let target = tableV.cellForRow(at: index!) as! bookListCell
        target.bookFrontImage.contentMode = .scaleAspectFill
        target.bookFrontImage.image = image
//        target.bookFrontImage.sd
//        delegate?.setCoverForOneBook(cellPath: index, imageData: image, bookName: target.bookName.text!)
        print("save Cover and look at bookName", target.bookName.text)
        if let bookName = target.bookName.text{
            if self.bookCoverData[target.bookName.text!] != nil{
                print("Have cover already")
            }else{
                if let data = UIImagePNGRepresentation(image){
                    print("save cover in local already2",data)
                    let index = tapped_course_code!.index((tapped_course_code?.startIndex)!, offsetBy: 2)
                    let program = tapped_course_code![...index] //such as Mat
                    storage?.child("bookCover/" + target.bookName.text! + ".png").putData(data, metadata: nil, completion: { (metadata, error) in
                        print("get into storage ready")
                        if let metadata = metadata {
                            let path = "course/" + program + self.tapped_course_code!
                            self.ref?.updateChildValues([path:["coverImage":metadata.downloadURL()]])
                        }
                    })
                    
                    set_coverImage(bookName: bookName, imageData: data.base64EncodedString())
                    print("save cover in local already")
                }else{
                    print("can not convert to data")
                }
                
            }
        }
        
    }
    
    
    
}
//
//protocol setCoverInCourseListDeletegate {
//    func setCoverForOneBook(cellPath:IndexPath,imageData:UIImage, bookName:String)
//}






