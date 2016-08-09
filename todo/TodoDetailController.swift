//
//  TodoDetailController.swift
//  todo
//
//  Created by sven liu on 16/8/9.
//  Copyright © 2016年 sven liu. All rights reserved.
//

import UIKit

protocol ProtocolTodoDetail {
    func addItem(item:TodoItem)
    func editItem()
}

class TodoDetailController: UITableViewController {
    
    var isAdd:Bool = true
    var todoItem   = TodoItem()
    var delegate : ProtocolTodoDetail?
    var datePickerVisible:Bool = false

    @IBOutlet weak var labLevel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UINavigationItem!
    @IBAction func done(sender: AnyObject) {
        todoItem.text = self.textField.text
        todoItem.shouldRemind = self.switchControl.on
        if isAdd {
            delegate?.addItem(todoItem)
        } else {
            delegate?.editItem()
        }
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func cancel(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func showDatePicker() {
        datePickerVisible = true
        let indexPathDatePicker = NSIndexPath(forRow: 3, inSection: 1)
        self.tableView.insertRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func hideDatePicker() {
        if datePickerVisible {
            datePickerVisible = false
            let indexPathDatePicker = NSIndexPath(forRow: 3, inSection: 1)
            self.tableView.deleteRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if isAdd {
            todoItem = TodoItem()
        } else {
            self.title = "编辑任务"
            textField.text = todoItem.text
            switchControl.on = todoItem.shouldRemind!
        }
        upDateDueDateLabel()
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
        if section == 1 && datePickerVisible {
            return 4
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func upDateDueDateLabel() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        self.dueDateLabel.text = formatter.stringFromDate(todoItem.dueDate!)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        textField.resignFirstResponder()
        if indexPath.section == 1 && indexPath.row == 2{
            if !datePickerVisible {
                self.showDatePicker()
            } else {
                self.hideDatePicker()
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 1 && indexPath.row == 3 {
            var cell = tableView.dequeueReusableCellWithIdentifier("DatePickerCell") as UITableViewCell?
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "DatePickerCell")
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
                let datePicker = UIDatePicker(frame: CGRectMake(0.0, 0.0, 320.0, 216.0))
                datePicker.tag = 100
                cell?.contentView.addSubview(datePicker)
                datePicker.addTarget(self, action: #selector(TodoDetailController.dateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
            }
            return cell!
        } else {
            return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        }
    }
    
    func dateChanged(datePicker: UIDatePicker) {
        todoItem.dueDate = datePicker.date
        upDateDueDateLabel()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 3 {
            return 217.0
        } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        if indexPath.section == 1 && indexPath.row == 3 {
            let newIndexPath = NSIndexPath(forRow: 0, inSection: indexPath.section)
            return super.tableView(tableView, indentationLevelForRowAtIndexPath: newIndexPath)
        } else {
            return super.tableView(tableView, indentationLevelForRowAtIndexPath: indexPath)
        }
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
