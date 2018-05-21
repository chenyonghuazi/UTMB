//
//  cropImage.swift
//  UTMB
//
//  Created by Edwin on 2018/5/19.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit

protocol setPortraitImageDelegate {
    func setImage(image:UIImage,view:UIViewController)
}
class cropImage: UIViewController,UITabBarDelegate {
    //IBoutlet
    @IBOutlet weak var cropRect:UIImageView!
    @IBOutlet weak var originalImage:UIImageView!
    @IBOutlet weak var tabBarC: UITabBar!
    //end
    
    //variables
    var originUIImage:UIImage?
    var delegate:setPortraitImageDelegate?
    //end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting view background color
            self.view.backgroundColor = UIColor.black
        //end
        //setting cropRect imageView
        let half_width = self.view.frame.width / 2
        let orginPointForCropRect = CGPoint(x: self.view.center.x - (half_width / 2), y: self.view.center.y - (half_width / 2))
        cropRect.frame = CGRect(origin: orginPointForCropRect, size: CGSize(width: half_width, height: half_width))
        cropRect.layer.borderWidth = 3
        cropRect.layer.borderColor = UIColor.white.cgColor
        self.view.bringSubview(toFront: cropRect)
        // end
        
        //setting background source image
        originalImage.image = originUIImage
        originalImage.contentMode = .scaleAspectFill
        //end
        
        //set up pan gesture
//        addPanGesture(view: cropRect)
        //end
    }
    
    //set up pan gesture recognizer for cropRect
    func addPanGesture(view:UIImageView){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(sender:)))
        view.addGestureRecognizer(pan)
    }

    @objc func handlePanGesture(sender:UIPanGestureRecognizer){
        let fileView = sender.view
        let transition = sender.translation(in: self.view)
        if sender.state == .began || sender.state == .changed{
            print("moving,x:",transition.x)
            print("moving,y:",transition.y)
            fileView!.center = CGPoint(x: fileView!.center.x + transition.x, y:fileView!.center.y + transition.y)
        }
    }
    
    @IBAction func panPerform(_ sender: UIPanGestureRecognizer) {
        let fileView = sender.view!
        print("get")
        let transition = sender.translation(in: sender.view)
        if sender.state == .began || sender.state == .changed{
            print("moving,x:",transition.x)
            print("moving,y:",transition.y)
            if ((fileView.frame.origin.x + fileView.frame.width + transition.x <= self.view.frame.width) && (fileView.frame.origin.y + transition.y >= originalImage.frame.origin.y) && (fileView.frame.origin.y + fileView.frame.height + transition.y <= originalImage.frame.origin.y + originalImage.frame.height) && (fileView.frame.origin.x + transition.x >= 0)){
                fileView.center = CGPoint(x: fileView.center.x + transition.x, y:fileView.center.y + transition.y)
                sender.setTranslation(CGPoint.zero
                    , in: sender.view)
            }
//            fileView.center = CGPoint(x: fileView.center.x + transition.x, y:fileView.center.y + transition.y)
//            sender.setTranslation(CGPoint.zero
//                , in: sender.view)
        }
        
    }
    
    //end
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.index(of: item){
            if  index == 0{
                self.dismiss(animated: true, completion: nil)
            }else if index == 1{
                
                if let image = originUIImage{
                    
                    let imageViewwidthScale = max((image.size.width) / originalImage.frame.size.width,
                                                  (image.size.height) / originalImage.frame.size.height)
                    
                    let cropZone = CGRect(x: cropRect.frame.origin.x * imageViewwidthScale, y: cropRect.frame.origin.y * imageViewwidthScale, width: cropRect.frame.size.width * imageViewwidthScale, height: cropRect.frame.size.height * imageViewwidthScale)
                    guard let originalImage_cropcgImage = originalImage.image?.cgImage?.cropping(to: cropZone) else {return }
                    let croppedImage = UIImage(cgImage: originalImage_cropcgImage)
                    self.dismiss(animated: true){
                        self.delegate?.setImage(image: croppedImage, view: self)//self.cropRect.frame
                    }
                }
                
//                let imageViewScale = max((originUIImage?.size.width)! / originalImage.frame.width,
//                                         (originUIImage?.size.height)! / originalImage.frame.height)
//                guard let originalImage_cropcgImage = originalImage.image?.cgImage?.cropping(to: cropRect.frame) else {return }
//                let croppedImage = UIImage(cgImage: originalImage_cropcgImage)
//                self.dismiss(animated: true){
//                    self.delegate?.setImage(image: croppedImage, view: self)
//                }
                
                
            }
        }
    }
}
