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
class bookList: UIViewController {
    var popOutV:UIView?
    var pdfAddress:UITextView?
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableV: UITableView!
    var ref:DatabaseReference?
    var tapped_course_code:String?
    var booklist = [String:String]()
    var bookWarehouse = [String:String]()
    var storage:StorageReference?
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observing()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = Storage.storage().reference()

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
    
    
    @IBAction func uploadNoice(_ sender: UIBarButtonItem) {
        let newView = popOutView()
        self.popOutV = newView
//        present(self.popOutV, animated: true, completion: nil)
        self.view.addSubview(self.popOutV!)
        self.view.bringSubview(toFront: self.popOutV!)
        self.popOutV?.isHidden = false
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
    }
    
    
    
}






