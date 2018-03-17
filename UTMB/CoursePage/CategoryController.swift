//
//  CategoryController.swift
//  UTMB
//
//  Created by Edwin on 2018/2/18.
//  Copyright © 2018年 Edwin. All rights reserved.
//

import UIKit

class CategoryController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    let digitToLetter = [0:"A",1:"B",2:"C",3:"D",4:"E",5:"F",6:"G",7:"H",8:"I",9:"J",10:"K",11:"L",12:"M",13:"N",14:"O",15:"P",16:"Q",17:"R",18:"S",19:"T",20:"U",21:"V"]
    let Ant = [101,102,199,200,201,202,203,204,205,206,207,208,209,210,211,212,214,215,220,241,299,306,308,309,310,312,313,314,316,317,318,320,322,327,331,332,333]
    let Csc = [104,108,148,199,207,209,236,258,263,290,299,300,301,309,310,318,320,321,322,324,333,338,343,347,358,363,369,373,384,398,399,404,409,411,420,422]
    let Mat = [100,102,133,134,135,137,157,202,212,223,224,232,233,236,240,244,247,257,299,301,302,309,311,315,332,334,344,378,382,388,392,401,402,405,406,478,488,492,498]
    var allProgram:[String:[String:[Int]]] = [String:[String:[Int]]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allProgram["A"] = ["Ant":Ant]
        allProgram["C"] = ["Csc":Csc]
        allProgram["M"] = ["Mat":Mat]
        // Do any additional setup after loading the view.
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
extension CategoryController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return digitToLetter.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let content = allProgram[digitToLetter[section]!]{
                return content.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "course")
        if let content = allProgram[digitToLetter[indexPath.section]!]{
            let values = Array(content.keys)
            
            cell.textLabel?.text = values[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            return cell
        }else{
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let destVC = story.instantiateViewController(withIdentifier: "courseList") as! courseList
        if let exist = allProgram[digitToLetter[indexPath.section]!]{
            let program = Array(exist.keys)
            let tapped = program[indexPath.row]
            let tapped_values = exist[tapped]
            var courseListData = [String]()
            for courseCode in tapped_values!{
                let pair = tapped + String(courseCode)
                courseListData.append(pair)
            }
            destVC.courseList = courseListData
            present(destVC, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return digitToLetter[section]
    }
    
    
}
