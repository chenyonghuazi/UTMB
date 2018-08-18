//
//  changeProfileInfo.swift
//  UTMB
//
//  Created by Edwin on 2018/5/26.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit

class changeProfileInfo: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        //setting the save button in navigationbar
//        let navigationbar = self.navigationController?.navigationBar
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
        saveButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = saveButton
        
    }
    @objc func handleSave(){
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

}
