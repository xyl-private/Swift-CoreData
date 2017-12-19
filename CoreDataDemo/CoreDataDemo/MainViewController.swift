//
//  MainViewController.swift
//  CoreDataDemo
//
//  Created by xyl~Pro on 2017/12/18.
//  Copyright © 2017年 xyl~Pro. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
   
    
    lazy var table:UITableView = {[weak self] in
        let table: UITableView = UITableView.init(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
        table.delegate = self
        table.dataSource = self
        //注册 cell
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
        }()
    var titles:[String] = ["Swift-Core Data(1) 基础","Swift-Core Data(2) 基础","Swift-Core Data(3) 基础"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       view.addSubview(table)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //swift 的 自定义 cell 重用
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = titles[indexPath.row]
        
        return cell
        
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(FirstVC(), animated: true)
        case 1:
            self.navigationController?.pushViewController(FirstVC(), animated: true)
        default:
            print("default")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


