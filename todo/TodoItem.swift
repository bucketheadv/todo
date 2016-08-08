//
//  TodoItem.swift
//  todo
//
//  Created by sven liu on 16/8/8.
//  Copyright © 2016年 sven liu. All rights reserved.
//

import UIKit

class TodoItem: NSObject {
    var text:String?
    var checked:Bool?
    var dueDate:NSDate?
    var shouldRemind:Bool?
    var itemId:Int?
    var level:Int = 0
    
    init(text:String, checked:Bool, dueDate:NSDate, shouldRemind:Bool, level:Int) {
        self.text = text
        self.checked = checked
        self.dueDate = dueDate
        self.shouldRemind = shouldRemind
        self.level = level
        super.init()
    }
    
    func onChangeChecked() {
        self.checked = !self.checked!
    }
}
