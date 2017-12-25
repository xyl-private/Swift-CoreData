//
//  FirstVC.swift
//  CoreDataDemo
//
//  Created by xyl~Pro on 2017/12/19.
//  Copyright © 2017年 xyl~Pro. All rights reserved.
//

import UIKit
import CoreData
class FirstVC: UIViewController {
    @IBOutlet weak var nameTF: UITextField!//姓名
    @IBOutlet weak var ageTF: UITextField!//年龄
    @IBOutlet weak var resultTextView: UITextView!//展示查询结果
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        let student = StudentModel(name: self.nameTF.text!, age: Int32(self.ageTF.text!)!)
        saveData(student: student)
    }
    
    func saveData(student stu:StudentModel){
        //第一步:获取总代理和托管对象托管对象上下文
        let app = UIApplication.shared.delegate as? AppDelegate
        let context = app?.persistentContainer.viewContext
        //第二步:创建实体,获取托管对象
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: context!)
        let student = NSManagedObject(entity: entity!, insertInto: context) as! Student
        //第三步:将数据赋值给托管对象
        student.name = stu.name
        student.age = stu.age
        //第四步:保存到数据库。如果保存失败，进行处理
        do {
            try context?.save()
        } catch  {
            fatalError("无法保存")
        }
    }
    
    @IBAction func showAction(_ sender: UIButton) {
        //第一步:获取总代理和托管对象托管对象上下文
        let app = UIApplication.shared.delegate as? AppDelegate
        let context = app?.persistentContainer.viewContext
        //第二步:建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        //第三步:执行请求
        do {
            //[Student] 这个位置填的是获取对象的类型
            //也可以使用 基类 NSManagedObject
            let fetch = try context?.fetch(fetchRequest) as? [Student]
            var resultStr:String = "查询结果\n"
            for student in fetch! {
                resultStr.append("name:\(student.name!)   age:\(student.age) \n")
            }
            self.resultTextView.text = resultStr
        } catch  {
            fatalError("无法查询")
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.view.backgroundColor = UIColor.white
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

