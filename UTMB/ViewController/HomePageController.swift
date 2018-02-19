//
//  HomePageController.swift
//  UTMB
//
//  Created by Edwin on 2018/2/18.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class HomePageController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var ref: StorageReference!
    var generalImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        ref = Storage.storage().reference()
//
//        ref.child("20171223.jpg").getData(maxSize: 1 * 1024 * 1024) { data, error in
//            if let error = error {
//                // Uh-oh, an error occurred!
//            } else {
//                // Data for "images/island.jpg" is returned
//                self.generalImage = UIImage(data: data!)!
//                self.tableView.reloadData()
//            }
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            return 5
        }
        else if section == 3{
            return 10
        }
        else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewerCell", for: indexPath) as! HomeViewerCell
            cell.cellImage.sd_setImage(with: URL(string:"https://firebasestorage.googleapis.com/v0/b/utmb-39117.appspot.com/o/20171223.jpg?alt=media&token=415377c4-7c0a-4f1b-9a58-212c827222e4")!, completed: nil)
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCategoryCell", for: indexPath) as! HomeCategoryCell
            return cell
        }
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeRecommandCell", for: indexPath) as! HomeRecommandCell
            cell.cellImage.sd_setImage(with: URL(string:"https://firebasestorage.googleapis.com/v0/b/utmb-39117.appspot.com/o/20171223.jpg?alt=media&token=415377c4-7c0a-4f1b-9a58-212c827222e4")!, completed: nil)
            return cell
        }
        else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNearbySellCell", for: indexPath) as! HomeNearbySellCell
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 160
        case 1:
            return 100
        case 2:
            return 100
        case 3:
            return 120
        default:
            return 44
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var tableView: UITableView!
    

}
