//
//  SecondChangeVC.swift
//  CoreDataDemo
//
//  Created by xyl~Pro on 2017/12/21.
//  Copyright © 2017年 xyl~Pro. All rights reserved.
//

import UIKit
import CoreData
class SecondChangeVC: UIViewController {

    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    
    var student:Student!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameTF.text = student.name
        self.ageTF.text = "\(String(describing: student.age))"
     
        self.navigationItem.title = "修改信息"
    }

    @IBAction func changeAction(_ sender: UIButton) {
        let app = UIApplication.shared.delegate as? AppDelegate
        
        let context = app?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        //设置查询条件
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(Student.name),(student?.name!)!)
       
        
        do {
            let fetchResult = try context?.fetch(fetchRequest) as! [Student]
            let stu = fetchResult[0]
            //更新的数据
            stu.name = self.nameTF.text
            stu.age = Int32(self.ageTF.text!)!
            //要保存数据库,否则 重新启动后,数据库中的数据会回到更改前的数据
            try context?.save()
        } catch  {

            
        }
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
