//
//  SettingsTableController.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 06/11/15.
//  Copyright © 2015 Team. All rights reserved.
//

import UIKit
import Parse

class SettingsTableController: UITableViewController {
    
    let items: [String] = ["My Account", "About", "Login"]
    var user: PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        tableView.separatorStyle = .None
    }
    
    override func viewDidAppear(animated: Bool) {
        user = PFUser.currentUser()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        if indexPath.row == 2{
            if user != nil{
                cell.textLabel?.text = "Logout"
            }
            
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            if user != nil {
//                performSegueWithIdentifier("SignUp", sender: self)
                let signUpVC = self.storyboard?.instantiateViewControllerWithIdentifier("SignUpViewController") as! SignUpTableViewController
                self.navigationController?.pushViewController(signUpVC, animated: true)
            }else{
                performSegueWithIdentifier("Login", sender: self)
            }
        }else if indexPath.row == 1{
            
        }else if indexPath.row == 2{
            if user != nil{
                PFUser.logOut()
                let alert = UIAlertController(title: "Logout", message: "You have successfully logged out.", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
                    
                self.navigationController?.popToRootViewControllerAnimated(true)
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }else{
                performSegueWithIdentifier("Login", sender: self)
            }
        }
    }
    
}
