//
//  SecondVC.swift
//  CoreDataDemo
//
//  Created by xyl~Pro on 2017/12/21.
//  Copyright © 2017年 xyl~Pro. All rights reserved.
//

import UIKit
import CoreData

class SecondVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var students:[Student]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "学生信息"
        initTableView()
        
        addRightItem()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.students = []
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          showData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - 排序
extension SecondVC{
    func addRightItem() -> Void {

        let ageItem = UIBarButtonItem(title: "age", style: UIBarButtonItemStyle.plain, target: self, action:#selector(SecondVC.addBillBtnAction(item:)))
        ageItem.tag = 0
        let nameItem = UIBarButtonItem(title: "name", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondVC.addBillBtnAction(item:)))
        nameItem.tag = 1
        navigationItem.rightBarButtonItems = [nameItem,ageItem]

        
    }

    @objc func addBillBtnAction(item:UIBarButtonItem) {
        switch item.title {
        case "age"?:
            print("age \(item.tag)")
            item.tag = item.tag == 0 ? 1:0
            sort(key: "age", ascending: item.tag == 0 ? true:false)
        case "name"?:
            print("name \(item.tag)")
            item.tag = item.tag == 0 ? 1:0
            sort(key: "name", ascending: item.tag == 0 ? true:false)
        default:
            print("default")
        }
        
    }
    
    
    func sort(key:String,ascending:Bool) -> Void {
        //第一步:获取总代理和托管对象托管对象上下文
        let app = UIApplication.shared.delegate as? AppDelegate
        let context = app?.persistentContainer.viewContext
        //第二步:建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        //请求的描述,按 money 从小到大排序
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "\(key)", ascending: ascending)]
        //请求的结果类型
        //        NSManagedObjectResultType：返回一个managed object（默认值）
        //        NSCountResultType：返回满足fetch request的object数量
        //        NSDictionaryResultType：返回字典结果类型
        //        NSManagedObjectIDResultType：返回唯一的标示符而不是managed object
        fetchRequest.resultType = .managedObjectResultType
        do {
            let fetchResult = try context?.fetch(fetchRequest) as! [Student]
            self.students = fetchResult
            self.tableView.reloadData()
        } catch  {
            
        }
    }
    
}


//MARK: - 删除学生
extension SecondVC {
    func deleteData(student:Student) -> Void {
        //第一步:获取总代理和托管对象托管对象上下文
        let app = UIApplication.shared.delegate as? AppDelegate
        let context = app?.persistentContainer.viewContext
        //第二步:建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        //设置查询条件
        fetchRequest.predicate  = NSPredicate(format: "%K == %@", #keyPath(Student.name),student.name!)
        
        do {
            let fetchResult = try context?.fetch(fetchRequest) as! [NSManagedObject]
            
            context?.delete(fetchResult[0])
            
            print("删除成功")
        } catch  {
            fatalError("请求数据失败")
      
        }
    }
}



//MARK: - 展示数据
extension SecondVC {
    func showData() -> Void {
        //第一步:获取总代理和托管对象托管对象上下文
        let app = UIApplication.shared.delegate as? AppDelegate
        let context = app?.persistentContainer.viewContext
        //第二步:建立一个获取的请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        do {
            let fetchResult = try context?.fetch(fetchRequest) as? [Student]
            students = fetchResult
            self.tableView.reloadData()
        } catch  {
            fatalError("请求数据失败")
        }
    }
}


//MARK: - UITableViewDelegate,UITableViewDataSource
extension SecondVC:UITableViewDelegate,UITableViewDataSource{
    func initTableView() -> Void {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //注册 cell
        self.tableView.register(UINib(nibName: "SecondTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        hildTableViewExtraCellLineHidden(tableView: self.tableView)
    }
    //MARK:隐藏多余的cell分割线
    func hildTableViewExtraCellLineHidden(tableView : UITableView){
        let view = UIView()
        view.backgroundColor = UIColor.clear
        tableView.tableFooterView = view
        tableView.tableHeaderView = view
    }
    
    //MARK: UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SecondTVCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! SecondTVCell
        let student:Student = students![indexPath.row]
    
        cell.nameLa.text = student.name
        cell.ageLa.text = "\(student.age)"
        return cell
    }
    
    
    //    左滑动的时候自定义两个按钮
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //删除cell
        let deleteAct : UITableViewRowAction = UITableViewRowAction(style: .default, title: "删除") { (UITableViewRowAction, NSIndexPath) in
            //从 CoreData 中删除
            self.deleteData(student: self.students![indexPath.row])
            //从 Source Data 中删除
            self.students!.remove(at: NSIndexPath.row)
            
            //删除 cell  动画效果  平滑删除
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            //刷新tableview
            tableView.reloadData()
        }
       
        let changeAct : UITableViewRowAction = UITableViewRowAction(style: .normal, title: "编辑") { (UITableViewRowAction, NSIndexPath) in
            let changeVC = SecondChangeVC()
            changeVC.student = self.students?[indexPath.row]
            
            self.navigationController?.pushViewController(changeVC, animated: true)
            
        }
        
        
        
        return [deleteAct,changeAct]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
}
