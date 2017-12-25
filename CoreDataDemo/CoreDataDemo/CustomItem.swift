//
//  CustomItem.swift
//  CoreDataDemo
//
//  Created by xyl~Pro on 2017/12/25.
//  Copyright © 2017年 xyl~Pro. All rights reserved.
//


import UIKit

extension UIBarButtonItem {
    
    convenience init(title:String,_ target: Any?, action: Selector) {
        
        let btn = UIButton.init(type: .custom)
        
        btn.setTitle(title, for: .normal)
        
        btn.setTitleColor(UIColor.blue, for: .normal)
        
        btn.addTarget(target, action: action , for: .touchUpInside)
        
        self.init(customView: btn)
    }
    
   

}
