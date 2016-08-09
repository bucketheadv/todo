//
//  TodoItem.swift
//  todo
//
//  Created by sven liu on 16/8/8.
//  Copyright © 2016年 sven liu. All rights reserved.
//

import UIKit

class TodoItem: NSObject {
    var text:String
    var checked:Bool
    var dueDate:NSDate
    var shouldRemind:Bool
    var itemId:Int = 0
    var level:Int = 0
    
    init(text:String="", checked:Bool=false, dueDate:NSDate=NSDate(), shouldRemind:Bool=false, level:Int=0) {
        self.text = text
        self.checked = checked
        self.dueDate = dueDate
        self.shouldRemind = shouldRemind
        self.level = level
        super.init()
    }
    
    init(coder aDecoder:NSCoder!){
        self.text = aDecoder.decodeObjectForKey("Text") as! String
        self.checked = aDecoder.decodeObjectForKey("Checked") as! Bool
        self.dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
        self.shouldRemind = aDecoder.decodeObjectForKey("ShouldRemind") as! Bool
        self.itemId = aDecoder.decodeObjectForKey("ItemId") as! Int
        self.level  = aDecoder.decodeObjectForKey("Level") as! Int
    }
    
    func encodeWithCoder(aCoder:NSCoder!) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeObject(checked, forKey: "Checked")
        aCoder.encodeObject(dueDate, forKey: "DueDate")
        aCoder.encodeObject(shouldRemind, forKey: "ShouldRemind")
        aCoder.encodeObject(itemId, forKey: "ItemId")
        aCoder.encodeObject(level, forKey: "Level")
    }
    
    func onChangeChecked() {
        self.checked = !self.checked
    }
    
    func scheduleNotification() {
        let existingNotification = self.notificationForThisItem()  as UILocalNotification?
        if existingNotification != nil {
            UIApplication.sharedApplication().cancelLocalNotification(existingNotification!)
        }
        if self.shouldRemind && (self.dueDate.compare(NSDate()) != NSComparisonResult.OrderedAscending) {
            let localNotification = UILocalNotification()
            localNotification.fireDate = self.dueDate
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.alertBody = self.text
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.userInfo = ["ItemID": self.itemId]
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        }
    }
    
    func notificationForThisItem() -> UILocalNotification? {
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications
        for notification in allNotifications! {
            var info = notification.userInfo as! Dictionary<String, Int>
            let number = info["itemID"]
            if number != nil && number == self.itemId {
                return notification
            }
        }
        return nil
    }
    
    deinit {
        let existingNotification = self.notificationForThisItem() as UILocalNotification?
        if existingNotification != nil {
            UIApplication.sharedApplication().cancelLocalNotification(existingNotification!)
        }
    }
}
