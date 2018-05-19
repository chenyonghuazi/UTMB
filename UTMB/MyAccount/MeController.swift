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
//    var section2
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        section1 = [settingModel(title: "finish profile", id: "", content: "", phoneNumber: "")]
        
        settingData = [0:section1!,1:section1!]
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
        let navigationBar = self.navigationController?.navigationBar
        let baricon = #imageLiteral(resourceName: "barIcon")
        let topicon = UIImageView(image: baricon)
        topicon.frame = CGRect(x: 2 * navigationBar!.frame.width / 3 - baricon.size.width / 2, y: navigationBar!.frame.height / 2 - baricon.size.height / 2, width: navigationBar!.frame.width / 2, height: navigationBar!.frame.height)
        topicon.contentMode = .scaleAspectFit
        navigationItem.titleView = topicon
        // Do any additional setup after loading the view.
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
            return cell}
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
    
}

