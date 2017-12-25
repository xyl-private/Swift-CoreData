//
//  ThreeVC.swift
//  CoreDataDemo
//
//  Created by xyl~Pro on 2017/12/22.
//  Copyright © 2017年 xyl~Pro. All rights reserved.
//

import UIKit
import CoreData
class ThreeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        context.refreshAllObjects()
    }

    
    //获取数据
    @IBOutlet weak var minLa: UILabel!
    @IBAction func minAction(_ sender: UIButton) {
        let result = fetch(forKeyPath: "age", forFunction: "min")
        self.minLa.text = "\(result)"
    }
    
    @IBOutlet weak var maxLa: UILabel!
    @IBAction func maxAction(_ sender: Any) {
        let result = fetch(forKeyPath: "age", forFunction: "max")
        self.maxLa.text = "\(result)"
    }
    
    
    @IBOutlet weak var countLa: UILabel!
    @IBAction func countAction(_ sender: Any) {
        let result = fetch(forKeyPath: "age", forFunction: "count")
        self.countLa.text = "\(result)"
    }
    
    @IBOutlet weak var averageLa: UILabel!
    @IBAction func average(_ sender: Any) {
        let result = fetch(forKeyPath: "age", forFunction: "average")
        self.averageLa.text = "\(result)"
    }
    
    @IBOutlet weak var sumActionLa: UILabel!
    @IBAction func sumAction(_ sender: Any) {
        let result = fetch(forKeyPath: "age", forFunction: "sum")
        self.sumActionLa.text = "\(result)"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ThreeVC {
    
    func fetch(forKeyPath key:String ,forFunction function:String) -> Any {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        //  请求的结果类型
        //  NSManagedObjectResultType：返回一个managed object（默认值）
        //  NSCountResultType：返回满足fetch request的object数量
        //  NSDictionaryResultType：返回字典结果类型
        //  NSManagedObjectIDResultType：返回唯一的标示符而不是managed object
        fetchRequest.resultType = .dictionaryResultType
        // 创建NSExpressionDescription来请求进行平均值计算，取名为AverageNum，通过这个名字，从fetch请求返回的字典中找到平均值
        let ed = NSExpressionDescription()
        ed.name = "result"
        //指定要进行平均值计算的字段名 age ,并设置返回类型
        let args = [NSExpression(forKeyPath: key)]
        // forFunction参数有sum:求和 count:计算个数 min:最小值 max:最大值 average:平均值等等
        // 注意:记得参数后面有 ':'
        ed.expression = NSExpression(forFunction: "\(function):", arguments: args)
        //计算后结果返回类型
        ed.expressionResultType = .floatAttributeType
        // 设置请求的propertiesToFetch属性为description告诉fetchRequest，我们需要对数据进行求平均值
        fetchRequest.propertiesToFetch = [ed]
        do {
            
            let entries =  try context.fetch(fetchRequest)
            
            let result = entries.first! as! NSDictionary
            
            let averageNum = result["result"]!
            
            return averageNum
        } catch  {
            
            print("failed")
            return "failed"
            
        }
    }
}
