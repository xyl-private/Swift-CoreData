//
//  WriteInfoVC.swift
//  CoreDataDemo
//
//  Created by xyl~Pro on 2017/12/22.
//  Copyright © 2017年 xyl~Pro. All rights reserved.
//

import UIKit
import CoreData
class WriteInfoVC: UIViewController {

    @IBOutlet weak var scoreTF: UITextField!
    @IBOutlet weak var subjectTX: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBAction func inputAction(_ sender: Any) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        
         //第二步:创建实体,获取托管对象
        //  let entity = NSEntityDescription.entity(forEntityName: "Student", in: context)
        //  let student = NSManagedObject(entity: entity!, insertInto: context) as! Student
        //第二步:创建实体可以简写成这个样子
        let student =  Student(context: context)
        
        student.name = self.nameTF.text
        student.age = Int32(self.ageTF.text!)!
        

        let grade =  Grade(context: context)

        grade.subject = self.subjectTX.text
        grade.score = Double(self.scoreTF.text!)!
        student.grade = grade
        
        //第四步:保存到数据库。如果保存失败，进行处理
        do {
            try context.save()
            print("保存成功")
        } catch  {
            fatalError("无法保存")
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
