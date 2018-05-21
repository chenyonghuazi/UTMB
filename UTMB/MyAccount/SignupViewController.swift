//
//  SignupViewController.swift
//  UTMB
//
//  Created by Edwin on 2018/2/18.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // variables
    var storage:StorageReference?
    var ref:DatabaseReference?
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        storage = Storage.storage().reference()
        //setting portrait imageview gesture
        let gesture = UITapGestureRecognizer(target: self, action: #selector(presentImagePickerView))
        portraitImage.isUserInteractionEnabled = true
        portraitImage.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var portraitImage: UIImageView!
    @IBAction func signup(_ sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordField.text!
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            else{
                //self.tabBarController?.selectedIndex = 0
                self.navigationController?.popToRootViewController(animated: true)
                guard let uid = user?.uid else {return}
                guard let email = user?.email else {return}
//                self.storeThings(uid: uid, email: email)
                self.storeThings2(uid: uid, email: email, completion: self.updateProfilesTest)
                
            }
            
        }
    }
}
//firebase function backup
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
//end


extension SignupViewController:setPortraitImageDelegate{
    func setImage(image: UIImage,view:UIViewController) {
//        image.draw(in: CGRect(origin: portraitImage.frame.origin, size: portraitImage.frame.size))
        portraitImage.image = image
        if let data = UIImageJPEGRepresentation(image,0.5){
            storage?.child("/portrait.png").putData(data, metadata: nil, completion: { (metadata, error) in
                if let metadata = metadata{
                    print(metadata.downloadURLs?.last)
                }
            })
        }
        
        portraitImage.contentMode = .scaleAspectFit
    }
    
    
}



