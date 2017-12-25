//
//  FourViewController.swift
//  CoreDataDemo
//
//  Created by xyl~Pro on 2017/12/22.
//  Copyright © 2017年 xyl~Pro. All rights reserved.
//

import UIKit
import CoreData
class FourViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var students:[Student]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "学生成绩表"
        //在原有基础上,添加了一张学生成绩表,property 是 subject(科目) 和 score(分数)
        //student to grade 是 一对多的  同学有多个科目,对应着多个成绩
        //grade to student 是 一对一的  一个成绩是某个同学的
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "录入", self, action: #selector(FourViewController.demo))
        initTableView()
    }
    
    @objc func demo() -> Void {
        print("录入")
        navigationController?.pushViewController(WriteInfoVC(), animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.students = []
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FourViewController{
    //获取学生列表
    func fetch() -> Void {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
       
        
        do {
            let result = try context.fetch(fetchRequest)
            students = result
            print("请求成功")
            tableView.reloadData()
        } catch  {
            fatalError("请求失败")
        }
    }
}



//MARK: -
extension FourViewController:UITableViewDelegate,UITableViewDataSource{
    func initTableView() -> Void {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let stu = students[indexPath.row]
        let info = "科目:\(stu.grade?.subject! ?? "--")    得分:\(stu.grade?.score ?? 0)"

        cell.textLabel?.text = "姓名:\(stu.name!) \(info)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
