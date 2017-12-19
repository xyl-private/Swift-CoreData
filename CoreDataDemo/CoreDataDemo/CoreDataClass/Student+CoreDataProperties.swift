//
//  Student+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by xyl~Pro on 2017/12/18.
//  Copyright © 2017年 xyl~Pro. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int32

}
