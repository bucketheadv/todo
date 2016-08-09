//
//  LevelItem.swift
//  todo
//
//  Created by sven liu on 16/8/9.
//  Copyright © 2016年 sven liu. All rights reserved.
//

import UIKit

class LevelItem: NSObject {
    var level:Int?
    var title:String = ""
    var checkMark:Bool = false
    init(level:Int) {
        self.level = level
        self.title = LevelItem.onGetTitle(level)
    }
    
    class func onGetTitle(level:Int) -> String {
        var title:String = ""
        switch level {
        case 0:
            title = "非常重要"
        case 1:
            title = "很重要"
        case 2:
            title = "重要"
        case 3:
            title = "一般"
        case 4:
            title = "可忽略"
        default:
            title = "非常重要"
        }
        return title
    }
}
