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

protocol coverImageDelegate {
    func setCover(cell:UITableViewCell ,image:UIImage)
}

class PDFView: UIViewController {
    
    var bookAddress:String?
    var cell:UITableViewCell?
    var coverdelegate:coverImageDelegate?
    var fileURL:URL?
    @IBOutlet weak var progressBar: UIProgressView!
    
    var myWebView:WKWebView?

    @IBAction func panPerform(_ sender: UIPanGestureRecognizer) {
        // 需要跟用户说明一下这个机制
        if sender.state == .began || sender.state == .changed{
            let translation = sender.translation(in: self.view).x
            // translation = new destination.x - old destination.x
            if translation > 100{
                
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setWkwebviewAndBar()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setWkwebviewAndBar(){
//        navigationBar.translatesAutoresizingMaskIntoConstraints = false
//        navigationBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 44))
//        navigationBar.alpha = 0.0
//        view.backgroundColor = UIColor.blue
        let webview = WKWebView()
        webview.navigationDelegate = self
        webview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webview)
        if #available(iOS 11.0, *) {
            webview.anchor(top: progressBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        } else {
            [webview.topAnchor.constraint(equalTo: progressBar.bottomAnchor),
             webview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             webview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             webview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ].forEach{$0.isActive = true}
        }
        
        
        view.bringSubview(toFront: webview)
        myWebView = webview
        
        if let getData = bookAddress {
            myWebView?.load(URLRequest(url: URL(string:getData)!))
        }else if let getFileData = fileURL{
            myWebView?.loadFileURL(getFileData, allowingReadAccessTo: getFileData)
        }
        
        
        
        myWebView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            
            self.progressBar.progress = Float(self.myWebView!.estimatedProgress)
            if self.progressBar.progress  == 1.0{
                var timer = Timer()
                timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(takeScreenshot), userInfo: nil, repeats: false)
                
            }
        }
    }
    
    

}

extension PDFView{
    @objc func takeScreenshot(){
        print("screenshotHere")
        UIGraphicsBeginImageContextWithOptions((self.myWebView?.bounds.size)!, true, 0);
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        image?.draw(in: CGRect(x: 0, y: 0, width: 133, height: 184))
        coverdelegate?.setCover(cell: self.cell!,image: image!)
        UIGraphicsEndImageContext()
        self.progressBar.isHidden = true
    }
    
}


extension PDFView:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        takeScreenshot()
        //发现没load 完就已经是didFinish 状态了 所以不能在这里screenshot
    }
//    webvi
    
    func screenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions((self.myWebView?.bounds.size)!, true, 0);
//            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true);
            let snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return snapshotImage;
    }
    
   
}
