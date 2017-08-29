//
//  SignUpTableViewController.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 28/11/15.
//  Copyright © 2015 Team. All rights reserved.
//

import UIKit
import Parse

class SignUpTableViewController: UITableViewController {
    
    var menuDict = [0 :["User Name:", "First Name:", "Last Name:", "Cuisine:", "Menu"]]
    let user = PFUser.currentUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "TextFieldTableCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
        self.title = "My Account"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return menuDict.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (menuDict[section]?.count)!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("TextFieldCell", forIndexPath: indexPath) as? TextFieldTableCell
        cell?.cellLabel?.text = menuDict[indexPath.section]![indexPath.row]
        cell?.textField.tag = indexPath.row
        cell?.textField.userInteractionEnabled = false
        tableView.rowHeight = 50
        if indexPath.row == 0{
            cell?.textField.text = user?.username
        }else if indexPath.row == 1{
            cell?.textField.text = user!["FirstName"] as? String
        }else if indexPath.row == 2{
            cell?.textField.text = user!["LastName"] as? String
        }else if indexPath.row == 4{
            cell?.cellLabel.alpha = 0
            cell?.textLabel?.text = "My Dishes"
            cell?.textLabel?.textColor = UIColor.darkGrayColor()
            cell?.accessoryType = .DisclosureIndicator
        }
        return cell!
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 4{
            let dishListVC = self.storyboard?.instantiateViewControllerWithIdentifier("DishList") as? DishListViewController
            self.navigationController?.pushViewController(dishListVC!, animated: true)
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
