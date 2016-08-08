//
//  TypeDetailViewController.swift
//  todo
//
//  Created by sven liu on 16/8/7.
//  Copyright © 2016年 sven liu. All rights reserved.
//

import UIKit

extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.startIndex.advancedBy(self.location)
        let endIndex   = startIndex.advancedBy(self.length)
        return startIndex..<endIndex
    }
}

class TypeDetailViewController: UITableViewController, ProtocolIconView, UITextFieldDelegate {
    var typeItem:TypeItem = TypeItem(name: "")
    var isAdd:Bool = true

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBAction func cancel(sender: AnyObject) {
        self.tabBarController?.selectedIndex = 0
        onAddType()
    }
    @IBAction func done(sender: AnyObject) {
        typeItem.name = textField.text!
        if isAdd {
            todoModel.onAddType(typeItem)
        }
        let navigation = self.tabBarController?.viewControllers?[0] as! UINavigationController
        let typeView = navigation.viewControllers.first as? TypeViewController
        typeView?.tableView.reloadData()
        self.tabBarController?.selectedIndex = 0
        onAddType()
    }
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    
    func onAddType() {
        isAdd = true
        typeItem = TypeItem(name: "")
        self.title = "添加"
        onUpdate()
    }
    
    func onEditType(item:TypeItem) {
        isAdd = false
        
        self.title = "编辑分类"
        self.typeItem = item
    }
    
    func onUpdate() {
        self.textField.text = typeItem.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        onUpdate()
        textField.becomeFirstResponder()
        if isAdd {
            doneButton.enabled = false
        } else {
            doneButton.enabled = true
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return super.numberOfSectionsInTableView(tableView)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func iconPicker(didPickIcon iconName: String) {
        typeItem.icon = iconName
        iconImageView.image = UIImage(named: iconName)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! IconViewController
        controller.delegate = self
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newText = textField.text!.stringByReplacingCharactersInRange(range.toRange(textField.text!), withString: string)
        doneButton.enabled = newText.characters.count > 0
        return true
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
