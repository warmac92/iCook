//
//  DishViewController.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 28/11/15.
//  Copyright © 2015 Team. All rights reserved.
//

import UIKit
import Parse

class DishViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate {

    @IBOutlet var dishTextfields: [UITextField]!
    
    @IBOutlet var dishName: UITextField!
    @IBOutlet var cuisine: UITextField!
    @IBOutlet var cost: UITextField!
    @IBOutlet var ingredients: UITextView!
    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet var dayAvailability: UIPickerView!
    
    let imagePicker = UIImagePickerController()
    var dishObject: Dish?
    let pickerData = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    let newDish = PFObject(className: "Dish")
    var config =  SwiftLoader.Config()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayAvailability.delegate = self
        dayAvailability.dataSource = self

        imagePicker.delegate = self
        
        for item in dishTextfields {
            item.delegate = self
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "saveNewDish")
        
        self.dishImageView.userInteractionEnabled = true
        self.dishImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "pickDishImage"))
        
        if let dish = dishObject{
            
            for item in dishTextfields{
                item.userInteractionEnabled = false
            }
            
            self.dishImageView.userInteractionEnabled = false
            
            self.dayAvailability.alpha = 0
            self.dishName.text = dish.name
            self.cuisine.text = dish.cuisine
            self.cost.text = "$\(String(dish.cost!))"
            self.ingredients.text = dish.ingredients
            self.ingredients.editable = false
            
            //Right bar button item
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editDishDetails")
            
            dish.dishImage?.getDataInBackgroundWithBlock({ (imageData, imageError) -> Void in
                if imageData != nil {
                    self.dishImageView.image = UIImage(data: imageData!)
                }
            })
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func editDishDetails() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "saveChanges")
        
        for item in dishTextfields {
            item.userInteractionEnabled = true
        }
        ingredients.userInteractionEnabled = true
    }
    
    func saveChanges() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editDishDetails")
    
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        return NSAttributedString(string: pickerData[row], attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
      newDish["Availability_Duration"] = pickerData[row]
        
    }
    
    func saveNewDish() {
        
        config.spinnerColor = UIColor.whiteColor()
        config.backgroundColor = UIColor(red: 255/255, green: 55/255, blue: 55/255, alpha: 0.8)
        config.foregroundAlpha = 0.5
        config.size = 150
        config.speed = 1
        config.titleTextColor = UIColor.whiteColor()
        SwiftLoader.setConfig(config)
        SwiftLoader.show("Saving...", animated: true)
        
        for item in dishTextfields {
            if item.tag == 1 {
                newDish["Name"] = item.text
            }else if item.tag == 2 {
                newDish["Cuisine"] = item.text
            }else if item.tag == 3 {
                newDish["Cost"] = Double(item.text!)
            }
        }
        newDish["Ingredients"] = ingredients.text
        newDish["UserId"] = PFUser.currentUser()?.objectId!
        newDish.saveInBackgroundWithBlock { (savedStatus, saveError) -> Void in
            
            if savedStatus {
                SwiftLoader.hide()
                let alert = UIAlertController(title: "Success", message: "Added a new item to your dish list.", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
//                    let viewControllers: [UIViewController] = (self.navigationController?.viewControllers)! as [UIViewController]
                    self.navigationController?.popViewControllerAnimated(true)
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }


    }
    
    func pickDishImage() {
        
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage  {
            self.dishImageView.image = pickedImage
            let pngImageData: NSData = UIImagePNGRepresentation(pickedImage)!
            newDish["Photo"] = PFFile(name: "image.png", data: pngImageData)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }

}
