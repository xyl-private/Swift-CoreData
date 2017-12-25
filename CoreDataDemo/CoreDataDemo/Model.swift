//
//  Model.swift
//  SwiftCoreData
//
//  Created by xyl~Pro on 2017/12/14.
//  Copyright © 2017年 xyl~Pro. All rights reserved.
//

import Foundation

struct User:Codable {
    
    var name: String
    var time: Date
    var age : Int32
    var money : Double
    
}
struct StudentModel:Codable {
    
    var name: String

    var age : Int32

    
}
