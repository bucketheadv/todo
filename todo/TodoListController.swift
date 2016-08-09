//
//  TodoListController.swift
//  todo
//
//  Created by sven liu on 16/8/8.
//  Copyright © 2016年 sven liu. All rights reserved.
//

import UIKit

class TodoListController: UITableViewController, ProtocolTodoDetail {
    var todoList:TypeItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.todoList?.name

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func addItem(item: TodoItem) {
        todoList?.items.append(item)
        self.tableView.reloadData()
    }
    
    func editItem() {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return super.numberOfSectionsInTableView(tableView)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoList!.items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = todoList!.items[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("todoCell", forIndexPath: indexPath) as UITableViewCell
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text + " \(LevelItem.onGetTitle(item.level))"
        onCheckmark(cell, item: item)

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = todoList!.items[indexPath.row]
        item.onChangeChecked()
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        onCheckmark(cell!, item: item)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func onCheckmark(cell:UITableViewCell, item:TodoItem) {
        let check = cell.viewWithTag(1002) as! UIImageView
        if item.checked {
            check.image = UIImage(named: "checkbox-checked")
        } else {
            check.image = UIImage(named: "checkbox-normal")
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        todoList!.items.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        todoModel.saveData()
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let controller = navigationController.topViewController as! TodoDetailController
        controller.delegate = self
        let segueStr = segue.identifier
        if segueStr == "AddItem" {
            controller.isAdd = true
        } else if segueStr == "EditItem" {
            let indexPath = self.tableView.indexPathForCell(sender! as! UITableViewCell)
            controller.todoItem = todoList!.items[indexPath!.row]
            controller.isAdd = false
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
