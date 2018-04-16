//
//  courseList.swift
//  UTMB
//
//  Created by Edwin on 2018/3/13.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit

class courseList: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    var courseList:[String]?
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "CourseList"
        navigationBar.backgroundColor = UIColor.black
        navigationBar.tintColor = UIColor.black
        // Do any additional setup after loading the view.
        let baricon = #imageLiteral(resourceName: "barIcon")
        let topicon = UIImageView(image: baricon)
        topicon.frame = CGRect(x: 2 * navigationBar.frame.width / 3 - baricon.size.width / 2, y: navigationBar.frame.height / 2 - baricon.size.height / 2, width: navigationBar.frame.width / 2, height: navigationBar.frame.height)
        topicon.contentMode = .scaleAspectFit
        navigationBar.topItem?.titleView = topicon
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

extension courseList: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "courseL")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = courseList![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let story = UIStoryboard(name: "Main", bundle: nil)
        let destVC = story.instantiateViewController(withIdentifier: "bookList") as! bookList
        destVC.tapped_course_code = courseList![indexPath.row]
        present(destVC, animated: true, completion: nil)
    }
}
//extension courseList:setCoverInCourseListDeletegate{
//    func setCoverForOneBook(cellPath: IndexPath, imageData: UIImage, bookName: String) {
//        if let data = UIImagePNGRepresentation(imageData){
//            if checkBookCover(bookName: bookName){
//                print("already have cover")
//            }else{
//                guard let imageData = String(data: data, encoding: String.Encoding.utf8) else{return }
//                set_coverImage(bookName: bookName, imageData: imageData)
//            }
//        }
//    }
//
//
//}
//
//extension courseList{
//    func checkBookCover(bookName:String) -> Bool{
//        if UserDefaults.standard.value(forKey: "CoverImage") == nil{
//            let coverImage = [String:String]()
//            UserDefaults.standard.set(coverImage, forKey: "CoverImage")
//            return false
//        }else{
//            let coverImageSet = UserDefaults.standard.value(forKey: "CoverImage") as! [String:String]
//            if coverImageSet[bookName] != nil{
//                return true
//            }else{
//                return false
//            }
//        }
//    }
//    func get_coverImage(bookName:String) -> String{
//
//        guard let warehouse = UserDefaults.standard.value(forKey: "CoverImage") as? [String:String] else{return "err"}
//        if let data = warehouse[bookName]{
//            return data
//        }
//        else{
//
//            return "nil"
//        }
//
//    }
//    func set_coverImage(bookName:String,imageData:String){
//        if !checkBookCover(bookName: bookName){
//            var newLocalBookData = UserDefaults.standard.value(forKey: "CoverImage") as! [String:String]
//            newLocalBookData[bookName] = imageData
//            UserDefaults.standard.set(newLocalBookData, forKey: "CoverImage")
//            print("setted!")
//        }
//    }
//}
