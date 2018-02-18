//
//  PDFView.swift
//  UTMB
//
//  Created by Edwin on 2018/2/18.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit
import FirebaseStorage
import WebKit

class PDFView: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    var myWebView:WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 44))
        
        view.backgroundColor = UIColor.blue
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webview)
        if #available(iOS 11.0, *) {
            webview.anchor(top: navigationBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        } else {
            [webview.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
             webview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             webview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ].forEach{$0.isActive = true}
        }
        webview.backgroundColor = UIColor.green
        view.bringSubview(toFront: webview)
        myWebView = webview
        load()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func load(){
        myWebView?.load(URLRequest(url: URL(string:"https://firebasestorage.googleapis.com/v0/b/utmb-39117.appspot.com/o/MAT344_Textbook.pdf?alt=media&token=15d84db1-d4a7-4ddf-aa3f-19693a505127")!))
    }

}


extension PDFView{
    func setNavButton(){
        navigationBar.items?.append(UINavigationItem.init(title: "bilibili"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handle))
        
    }
    @objc func handle(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension PDFView:UIScrollViewDelegate{
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if abs(scrollView.contentOffset.y) > view.frame.height{
            navigationBar.alpha = 0
            myWebView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        }else{
            navigationBar.alpha = 1.0
            myWebView?.topAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        }
    }
}
