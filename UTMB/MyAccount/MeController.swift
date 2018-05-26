//
//  MeController.swift
//  UTMB
//
//  Created by Edwin on 2018/2/18.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit
import Firebase

class MeController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var settingData:[Int:[settingModel]]?
    var section1:[settingModel]?
    var database:DatabaseReference?
    var userInfo:[String:String] = [String:String]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        database = Database.database().reference()
        section1 = [settingModel(title: "finish profile", id: "", content: "", phoneNumber: "")]
        
        settingData = [0:section1!,1:section1!]
        
        //update the portrait and user info
        if let user = Auth.auth().currentUser{
            getUserData(uid: user.uid)
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let content = "signout"
//
//        let title = UIFont(name: "Savoye Let", size: 30)
//        let content_title = NSAttributedString(string: "signout", attributes: [NSAttributedStringKey.font : title])
        let button = UIBarButtonItem(title: "Signout", style: .plain, target: self, action: #selector(handleSignout))
        button.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Savoye Let", size: 30)!], for: UIControlState.normal)
        
        navigationItem.leftBarButtonItem = button
        //start of setting titleView
        
//        let navigationBar = self.navigationController?.navigationBar
//        let baricon = #imageLiteral(resourceName: "barIcon")
//        let topicon = UIImageView(image: baricon)
//        topicon.frame = CGRect(x: 2 * navigationBar!.frame.width / 3 - baricon.size.width / 2, y: navigationBar!.frame.height / 2 - baricon.size.height / 2, width: navigationBar!.frame.width / 2, height: navigationBar!.frame.height)
//        topicon.contentMode = .scaleAspectFit
//        navigationItem.titleView = topicon
  
        
        //end of setting navigationItem's titleView
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleSignout(){
        if Auth.auth().currentUser != nil{
            try? Auth.auth().signOut()
        }
        else{
            let alert = UIAlertController(title: "Logout error", message: "already loged out", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
   
    
    @IBOutlet weak var tableView: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return (settingData?.count)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0{
//            return 1
//        }
//        else if section == 1{
//            return 5
//        }else{
//            return 3
//        }
        return settingData![section]!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MeLoginCell", for: indexPath) as! MeLoginCell
            if userInfo != [String:String](){
                if let portraitData = userInfo["portrait"]{
                    guard let url = URL(string: portraitData) else{return UITableViewCell()}
                cell.portraitV.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "portraitPlaceholder"))
                    cell.portraitV.clipsToBounds = true
                    cell.portraitV.layer.cornerRadius = cell.portraitV.frame.width / 2
                }
            }

                return cell
            
        }
        else if indexPath.section == 1{
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = settingData![indexPath.section]![indexPath.row].title
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0{
            if Auth.auth().currentUser == nil{
                performSegue(withIdentifier: "loginNow", sender: nil)
            }else{
                alertSystem(message: "You have signed in", checkLogin: true)
            }
        }else if indexPath.section == 1 && indexPath.row == 0{
            if Auth.auth().currentUser != nil{
                performSegue(withIdentifier: "detail", sender: nil)
            }else{
                alertSystem(message: "please login first.",checkLogin: false)
            }
            
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return "Profile"
        }
        return ""
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "loginNow" && Auth.auth().currentUser == nil{
            segue.destination.hidesBottomBarWhenPushed = true
            
            if Auth.auth().currentUser != nil {
                
            }
        }
    }
    
    func alertSystem(message:String,checkLogin:Bool){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        if !checkLogin{
            alert.addAction(UIAlertAction(title: "login Now", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "loginNow", sender: nil)
            }))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
//get data method
extension MeController{
    func getUserData(uid:String){
        
        let user = User(email: "", phone: "", portrait: "")
        database?.child("user").child(uid).observe(.value) { (snapshot) in
            if snapshot.value != nil{
                
                if let data = snapshot.value as? [String:String]{
                    
                    for (key,value) in data{
                        
                        if key == "phone"{
                            self.userInfo["phone"] = value
                        }else if key == "portrait"{
                            self.userInfo["portrait"] = value
                        }
                        self.tableView.reloadData()
                    }
                    
                }
                self.tableView.reloadData()
            }
            
        }
//        if user.phone != ""{
//            if user.portrait != ""{
//                return ["phone":user.phone!,"portrait":user.portrait!]
//            }else{
//                return ["phone":user.phone!,"portrait":""]
//            }
//        }else if user.portrait != nil{
//            return ["phone":"","portrait":user.portrait!]
//        }else{
//            return ["phone":"","portrait":""]
//        }
        
    }
}

