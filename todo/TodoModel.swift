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
        //onCreateData()
        loadData()
        print("沙盒文件夹路径: \(documentsDirectory())")
        print("数据文件路径: \(dataFilePath())")
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
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory:String = paths.first! as String
        return documentsDirectory
    }
    
    func dataFilePath() -> String {
        return self.documentsDirectory().stringByAppendingString("/todo.plist")
    }
    
    func saveData() {
        let data = NSMutableData()
        
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(typeList, forKey: "todolist")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadData() {
        let path = self.dataFilePath()
        let defaultManager = NSFileManager()
        if defaultManager.fileExistsAtPath(path) {
            print("存在了")
            let data = NSData(contentsOfFile: path)
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data!)
            typeList = unarchiver.decodeObjectForKey("todolist") as! Array
            unarchiver.finishDecoding()
        } else {
            let type = TypeItem(name: "女神有关")
            typeList.append(type)
            saveData()
        }
    }
}

var todoModel = TodoModel()