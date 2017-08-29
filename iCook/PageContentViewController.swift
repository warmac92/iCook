//
//  PageContentViewController.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 28/10/15.
//  Copyright © 2015 Team. All rights reserved.
//

import UIKit
import Parse

class PageContentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{


    @IBOutlet var tableView: UITableView!

    var pageIndex: Int?
    var users = [User]()
    var dishes = [Dish]()
    var userDict = [String: User]()
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserData()
        fetchDishData()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNib(UINib(nibName: "DishesTableViewCell", bundle: nil), forCellReuseIdentifier: "DishCell")
        tableView.registerNib(UINib(nibName: "CooksTableViewCell", bundle: nil), forCellReuseIdentifier: "CookTableCell")
        
        tableView.separatorStyle = .None
        tableView.rowHeight = 220

        
    }

    func fetchUserData(){
        
        let query = PFQuery(className: "_User")
        query.findObjectsInBackgroundWithBlock { (userObjects, fetchError) -> Void in
            
            if fetchError == nil{
                
                    for item in userObjects!{
                        self.users.append(User(responseObject: item))
                        self.userDict[item.objectId!] = User(responseObject: item)
                    }
                
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchDishData(){
        
        let query = PFQuery(className: "Dish")
        query.findObjectsInBackgroundWithBlock { (dishObjects, fetchError) -> Void in
            
            if fetchError == nil{
                for item in dishObjects!{
                    self.dishes.append(Dish(dishObject: item))
                }
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pageIndex == 0{
            return dishes.count
        }else{
            return users.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if pageIndex == 0{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("DishCell") as! DishesTableViewCell
            cell.selectionStyle = .None
            let currentUser = userDict[dishes[indexPath.row].userId]
            
            if ((users.count > 0) && (dishes.count > 0)){
                
                cell.sellerName.text = (currentUser?.firstName)! + " " + (currentUser?.lastName)!
                    
                cell.dishName.text = dishes[indexPath.row].name
                cell.ratings.rating = Double((currentUser?.rating)!)
                
                currentUser!.profilePic?.getDataInBackgroundWithBlock({ (imageData, imageError) -> Void in
                    
                    if imageData != nil {
                        if let image = imageData{
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                cell.userImage.image = UIImage(data: image)
                                
                            })
                            
                        }
                    }
                })
                
                dishes[indexPath.row].dishImage?.getDataInBackgroundWithBlock({ (dishImageData, imageError) -> Void in
                    
                    if dishImageData != nil{
                        
                        if let imageData = dishImageData{
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                cell.dishImage.image = UIImage(data: imageData)
                            })
                        }
                    }
                })
            }

            return cell
            
        }else{
            
            tableView.rowHeight = 100
            
            let cell = tableView.dequeueReusableCellWithIdentifier("CookTableCell") as! CooksTableViewCell
            cell.selectionStyle = .None
            if users.count > 0{
                cell.cookName.text = users[indexPath.row].firstName + " "+users[indexPath.row].lastName
                cell.cuisine.text = users[indexPath.row].cuisine
                cell.ratingsView.rating = Double(users[indexPath.row].rating!)
                users[indexPath.row].profilePic?.getDataInBackgroundWithBlock({ (userImageData, imageDataError) -> Void in
                    
                    if userImageData != nil{
                        
                        if let imageData = userImageData{
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                cell.userImage.image = UIImage(data: imageData)
                            })
                            
                        }
                    }
                })
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row

        if pageIndex == 0{
            performSegueWithIdentifier("pushDishDetail", sender: self)
        }else if pageIndex == 1{
            performSegueWithIdentifier("pushUserDetail", sender: self)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        self.customizeCell(cell)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if pageIndex == 0 {
            
            let dishDetailVC = segue.destinationViewController as! DishDetailsViewController
            dishDetailVC.dishObject = dishes[selectedIndex]
            dishDetailVC.userObject = userDict[dishes[selectedIndex].userId]
            
        }else if pageIndex == 1 {
            
            let userTableVC = segue.destinationViewController as! UserTableViewController
            userTableVC.userObject = users[selectedIndex]
        }
        
    }
    
    // TableviewCell animation
    
    func customizeCell(cell: UITableViewCell) {
        
        var rotate: CATransform3D
        
        let value = CGFloat((90.0 * M_PI) / 180.0)
        
        rotate = CATransform3DMakeRotation(value, 0, 0.7, 0.4)
        
        rotate.m34 = 1.0 / -600
        
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(10, 10)
        cell.alpha = 0
        
        cell.layer.transform = rotate
        cell.layer.anchorPoint = CGPointMake(0, 0.5)
        
        if(cell.layer.position.x != 0){
            cell.layer.position = CGPointMake(0, cell.layer.position.y);
        }
        
        UIView.beginAnimations("rotate", context: nil)
        UIView.setAnimationDuration(0.8)
        cell.layer.transform = CATransform3DIdentity
        cell.alpha = 1
        cell.layer.shadowOffset = CGSizeMake(0, 0)
        UIView.commitAnimations()
        
    }

    
}
