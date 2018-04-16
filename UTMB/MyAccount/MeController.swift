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

//    var settingData:[Int:[settingModel]]?
//    var section1:[settingModel]?
//    var section2
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem(title: "signout", style: .plain, target: self, action: #selector(handleSignout))
        
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
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeLoginCell", for: indexPath) as! MeLoginCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0{
            if Auth.auth().currentUser == nil{
                performSegue(withIdentifier: "loginNow", sender: nil)
            }
        }
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
