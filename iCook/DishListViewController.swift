//
//  DishListViewController.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 28/11/15.
//  Copyright © 2015 Team. All rights reserved.
//

import UIKit
import Parse


class DishListViewController: UITableViewController {
    
    var dishes = [Dish]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addNewDish")
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    func fetchDishes() {
        let query = PFQuery(className: "Dish")
        query.whereKey("UserId", containsString: PFUser.currentUser()?.objectId)
        query.findObjectsInBackgroundWithBlock { (dishObjects, error) -> Void in
            if dishObjects != nil{
                for item in dishObjects! {
                    self.dishes.append(Dish(dishObject: item))
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.tableView.reloadData()
                        
                    })
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.dishes = [Dish]()
        self.fetchDishes()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dishes.count > 0 {
            return dishes.count
        }else {
            return 0
        }

    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        cell.accessoryType = .DisclosureIndicator
        if dishes.count > 0 {
            cell.textLabel?.text = dishes[indexPath.row].name
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dishVC = self.storyboard?.instantiateViewControllerWithIdentifier("DishDetails") as! DishViewController
        dishVC.dishObject = dishes[indexPath.row]
        self.navigationController?.pushViewController(dishVC, animated: true)
    }
    
    func addNewDish() {
        let dishVC = self.storyboard?.instantiateViewControllerWithIdentifier("DishDetails") as! DishViewController
        self.navigationController?.pushViewController(dishVC, animated: true)
        
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
