//
//  DishDetailsViewController.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 19/11/15.
//  Copyright © 2015 Team. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class DishDetailsViewController: UIViewController {

    var dishObject: Dish!
    var userObject: User!
    var dishImageData: NSData!

    @IBOutlet var dishImagView: UIImageView!
    @IBOutlet var availability: UILabel!
    @IBOutlet var ingredients: UITextView!
    @IBOutlet var dishPrice: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userRatings: CosmosView!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var homeDelivery: UILabel!
    @IBOutlet var phone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = dishObject.name
        userImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "showUserDetails")
        userImageView.addGestureRecognizer(tap)
        
        dishPrice.text = "$" + "\(dishObject.cost!)"
        userName.text = userObject.firstName + " " + userObject.lastName
        
        userRatings.rating = Double(userObject.rating!)
        userRatings.settings.updateOnTouch = false
        
        ingredients.text = dishObject.ingredients
        ingredients.editable = false
        
        availability.text = dishObject.availabilityDuration
        phone.text = userObject.phone
        
        if userObject.homeDelivery == true {
            homeDelivery.text = "Available"
        }else{
            homeDelivery.text = "Not Available"
        }
        //Adding dish image
        dishObject.dishImage?.getDataInBackgroundWithBlock({ (imageData, imageError) -> Void in
            if imageData != nil {
                if let data = imageData{
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.dishImagView.image = UIImage(data: data)
                        self.dishImageData = data
                        self.dishImagView.userInteractionEnabled = true
                        self.dishImagView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "showImageViewer"))
                    })
                    
                }
            }
        })
        
        //Adding user image
        userObject.profilePic?.getDataInBackgroundWithBlock({ (imageData, imageError) -> Void in
            
            if imageData != nil {
                if let data = imageData{
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.userImageView.image = UIImage(data: data)
                    })
                }
            }
                
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.clipsToBounds = true
        userRatings.settings.borderWidthEmpty = 0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showUserDetails() -> Void {
        performSegueWithIdentifier("userDetails", sender: self)
    }
    
    @IBAction func moreFromTheCook(sender: AnyObject) {
        
        showUserDetails()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let userDetailsVC = segue.destinationViewController as? UserTableViewController
        userDetailsVC?.userObject = self.userObject
    }
    
    func showImageViewer() {
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImage(UIImage(data: dishImageData)!)
        images.append(photo)
        
        // Creating PhotoBrowser Instance, and present.
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        presentViewController(browser, animated: true, completion: {})
    }

}
