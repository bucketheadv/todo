//
//  TypeItem.swift
//  todo
//
//  Created by sven liu on 16/8/7.
//  Copyright © 2016年 sven liu. All rights reserved.
//

import UIKit

class TypeItem: NSObject {
    var items = [TodoItem]()
    //分类名
    var name:String = ""
    //分类图标
    var icon:String = "提醒"
    
    init(name:String) {
        super.init()
        self.name = name
    }
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items {
            if item.checked != true {
                count += 1
            }
        }
        return count
    }
}