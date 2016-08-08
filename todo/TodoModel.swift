//
//  TodoModel.swift
//  todo
//
//  Created by sven liu on 16/8/7.
//  Copyright © 2016年 sven liu. All rights reserved.
//

import UIKit

class TodoModel: NSObject {
    var typeList = [TypeItem]()
    
    override init() {
        super.init()
        onCreateData()
    }
    
    func onCreateData() {
        for i in 1...10 {
            let name = "任务: \(i)"
            let type = TypeItem(name: name)
            for j in 0...4 {
                let todo = TodoItem(text: "任务清单: \(j)", checked: false, dueDate: NSDate(), shouldRemind: true, level: 0)
                type.items.append(todo)
            }
            typeList.append(type)
        }
    }
    
    func onAddType(type:TypeItem) {
        typeList.append(type)
    }
    
    class func nextTodoItemId() -> Int {
        return 0
    }
}

var todoModel = TodoModel()