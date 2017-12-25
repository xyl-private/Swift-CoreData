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
        hildTableViewExtraCellLineHidden(tableView: table)
        return table
        }()
    var titles:[String] = ["(1) 初级","(2) 初级 (查、改、删)","(3) 初级 (计算平均数、总和、最大/小值等)","(4) 进阶 多表关联操作"]
    
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
        
        let vcs = [FirstVC(),SecondVC(),ThreeVC(),FourViewController()]
        let vc = vcs[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    //MARK:隐藏多余的cell分割线
    func hildTableViewExtraCellLineHidden(tableView : UITableView){
        let view = UIView()
        view.backgroundColor = UIColor.clear
        tableView.tableFooterView = view
        tableView.tableHeaderView = view
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


