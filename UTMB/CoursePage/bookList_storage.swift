//
//  bookList_storage.swift
//  UTMB
//
//  Created by Edwin on 2018/3/19.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import Foundation
import Firebase
import MessageUI
extension bookList:UITextFieldDelegate,MFMailComposeViewControllerDelegate{
    
    func popOutView() -> UIView{
        self.view.alpha = 0.5
        let newView = UIView(frame: CGRect(origin: self.view.center, size: CGSize(width: self.view.frame.width * 0.6, height: self.view.frame.width * 0.6 * 0.75))) // 4:3 ratio 例如 375:667 => 187.5:140.625
//        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 20)))
        let label = UILabel()
        label.text = "PDF_Url:"
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 15)
        label.anchor(top: newView.topAnchor, leading: newView.leadingAnchor, bottom: newView.bottomAnchor, trailing: nil, padding: .init(top: 64, left: 10, bottom: 64, right: 0), size: .init(width: 44, height: 0))
        newView.addSubview(label)
        let button = UIButton()
        button.anchor(top: newView.topAnchor, leading: nil, bottom: newView.bottomAnchor, trailing: newView.trailingAnchor, padding: .init(top: 64, left: 0, bottom: 64, right: 10), size: .init(width: 44, height: 0))
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        button.titleLabel?.text = "Send"
        let pdfAddress = UITextView()
        pdfAddress.anchor(top: newView.topAnchor, leading: label.trailingAnchor, bottom: newView.bottomAnchor, trailing: button.leadingAnchor, padding: .init(top: 64, left: 5, bottom: 64, right: 0))
        self.pdfAddress = pdfAddress
        newView.addSubview(pdfAddress)
        return newView
    }
    
    @objc func handleButton(){
        
        if self.pdfAddress?.text != nil || self.pdfAddress?.text != ""{
            let mailComposeViewController = configureMailController()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailComposeViewController, animated: true, completion: nil)
            }else{
                showMailError()
            }
            
        }else{
//            dismiss(animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        if self.popOutV != nil && touches.first?.view != self.popOutV{
            self.popOutV!.isHidden = true
        }
    }
    
    func configureMailController() ->  MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["utmboffice.chen@gmail.com"])
        mailComposerVC.setSubject(self.tapped_course_code!)
        mailComposerVC.setMessageBody((self.pdfAddress?.text)!, isHTML: false)
        return mailComposerVC
    }
    
    func showMailError(){
        let sendMailErrorAlert = UIAlertController(title: "Couldn't send email", message: "Check the Internet connection or device", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(sendMailErrorAlert, animated: true, completion: nil)
        
 }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}
