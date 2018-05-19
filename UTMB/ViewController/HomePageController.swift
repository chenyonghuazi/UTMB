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
    var datahandle:DatabaseHandle?
    var dataref:DatabaseReference?
    var ref: StorageReference!
    var generalImage = UIImage()
    var topScrollViewImageSet = [String]()
    
    @IBOutlet weak var tableV: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observering()
        tableView.reloadData()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        dataref = Database.database().reference()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        
        let Image = #imageLiteral(resourceName: "wallpaper")
        backgroundImage.image = Image
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let navigationBar = self.navigationController?.navigationBar
        let baricon = #imageLiteral(resourceName: "barIcon")
        let topicon = UIImageView(image: baricon)
        topicon.frame = CGRect(x: 2 * navigationBar!.frame.width / 3 - baricon.size.width / 2, y: navigationBar!.frame.height / 2 - baricon.size.height / 2, width: navigationBar!.frame.width / 2, height: navigationBar!.frame.height)
        topicon.contentMode = .scaleAspectFit
        navigationItem.titleView = topicon
        //navigationBar?.backgroundColor = UIColor.blue
        //self.navigationController?.navigationBar.tintColor = UIColor.blue
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 110, green: 193, blue: 248, alpha: 1)
        navigationBar?.barTintColor = UIColor(patternImage: Image)
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
//        observering()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
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
            if self.topScrollViewImageSet != []{
                cell.imageData = self.topScrollViewImageSet
                cell.setImage()
            }
            
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCategoryCell", for: indexPath) as! HomeCategoryCell
            cell.delegate = self
            return cell
        }
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeRecommandCell", for: indexPath) as! HomeRecommandCell
            let image = #imageLiteral(resourceName: "book1")
            cell.cellImage.image = image
            
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
// for presentPostSell delegate
extension HomePageController:presentPostSellVCdelegate{
    func presentPostSell(cell: UICollectionViewCell) {
        print("gothere")
        performSegue(withIdentifier: "postSell", sender: nil)
    }
}
