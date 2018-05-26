//
//  detailVC.swift
//  UTMB
//
//  Created by Edwin on 2018/4/16.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
class detailVC: UIViewController {

    @IBOutlet weak var profileTableV: UITableView!
    var dict:[String:String]?
    var userInfo:[String:String]?
    var database:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.topItem?.title = "Profile"
        // Do any additional setup after loading the view.
        self.title = "Profile"
//        guard let uid = Auth.auth().currentUser?.uid else{return}
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        database = Database.database().reference()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

}
extension detailVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "touxiang") as! portrait
            if userInfo != nil{
                if userInfo!["portrait"] != nil{
                    let portraitURL = URL(string: userInfo!["portrait"]!)
                    cell.portraitV.sd_setImage(with: portraitURL, completed: nil)
                }
            }
            cell.accessoryType = .disclosureIndicator
            return cell
        }else{
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "")
            if userInfo != nil{
                if userInfo!["phone"] != nil{
                    cell.detailTextLabel?.text = userInfo!["phone"]
                }
            }
            cell.textLabel?.text = "Phone number"
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 150
        }else{
            return 100
        }
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension detailVC{

}
