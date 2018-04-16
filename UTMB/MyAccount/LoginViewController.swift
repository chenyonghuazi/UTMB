//
//  LoginViewController.swift
//  UTMB
//
//  Created by Edwin on 2018/2/18.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit
import Firebase

protocol goToHomePageDelegate{
    func goHomePage()
}

class LoginViewController: UIViewController {

    var goHomePage:goToHomePageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func loginAction(_ sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordField.text!
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.statusLabel.text =  error?.localizedDescription
            }
            else{
                self.navigationController?.popViewController(animated: true)
                let homePage = HomePageController()
                self.present(homePage, animated: true, completion: nil)
                
            }
            
            
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

}
