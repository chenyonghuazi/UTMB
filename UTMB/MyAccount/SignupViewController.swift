//
//  SignupViewController.swift
//  UTMB
//
//  Created by Edwin on 2018/2/18.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    
    var ref:DatabaseReference?
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
//        Auth.auth().currentUser.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBAction func signup(_ sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordField.text!
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            else{
                //self.tabBarController?.selectedIndex = 0
                self.navigationController?.popViewController(animated: true)
                guard let uid = user?.uid else {return}
                guard let email = user?.email else {return}
//                self.storeThings(uid: uid, email: email)
                self.storeThings2(uid: uid, email: email, completion: self.updateProfilesTest)
                
            }
            
        }
    }
}

extension SignupViewController{
    
    func storeThings(uid:String, email:String){
        let key = ref?.child("user").childByAutoId().key
        ref?.child("user").child(key!).setValue(["userId":uid,"email":email]);
//        completion(key!)
    }
    
    func storeThings2(uid:String, email:String,completion:(_ key:String) -> Void){
        
//        let key = ref?.child("user").childByAutoId().key
//        ref?.child("user").child(key!).setValue(["userId":uid,"email":email]);
        //completion(key!)
        ref?.child("user").child(uid).setValue(["email":email])
//        completion(key!)
    }
    
    func updateProfilesTest(key:String){
        let update = [
            "location":"100,100",
            "phoneNumber":"123456789",
            "email":"asdasdasd"
        ]
        let childUpdates = ["/user/\(key)":update]
        ref?.updateChildValues(childUpdates)
    }
}
