//
//  portraitImageGesture.swift
//  UTMB
//
//  Created by Edwin on 2018/5/19.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import Foundation
import UIKit

// it is a extension file for UIImagePickerController
// not for Pan gesture

extension SignupViewController{
    @objc func presentImagePickerView(){
        let view = UIImagePickerController()
        view.delegate = self
        view.allowsEditing = false
        view.sourceType = .photoLibrary
        
        present(view, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
//            let story = UIStoryboard(name: "Main", bundle: nil)
//            let destVC = story.instantiateViewController(withIdentifier: "cropImage") as! cropImage
//            destVC.originUIImage = image
//            destVC.delegate = self
////            present(destVC, animated: true, completion: nil)
//            self.dismiss(animated: true) {
//                self.present(destVC, animated: true, completion: nil)
//            }
            portraitImage.image = image
            portraitImage.layer.cornerRadius = portraitImage.frame.width / 2
            checkPortrait = true
//            portraitImage.image = image
//            portraitImage.contentMode = .scaleAspectFit
        }else{
            print("error image!")
        }
        self.dismiss(animated: true, completion: nil)
       
    }
}
