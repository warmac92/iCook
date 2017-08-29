//
//  LoginViewController.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 27/11/15.
//  Copyright © 2015 Team. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var loginTextFields:
     [UITextField]!
    
    @IBOutlet var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for item in loginTextFields{
            item.attributedPlaceholder = NSAttributedString(string: item.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor(red: 255/255, green: 231/255, blue: 220/255, alpha: 1)])
            item.delegate = self
            item.alpha = 0
        }
        loginButton.layer.cornerRadius = 6
        loginButton.alpha = 0
        
    }
    

    
    override func viewDidAppear(animated: Bool) {

        UIView.animateWithDuration(0.8, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.6, options: .CurveLinear, animations: { () -> Void in
            
            for item in self.loginTextFields {
                item.center.x = self.view.center.x
                item.alpha = 1
            }
            self.loginButton.alpha = 1
            
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(sender: AnyObject) {
        var username: String?
        var password: String?
        for item in loginTextFields{
            if item.tag == 1{
                if item.text?.characters.count > 0 {
                    username = item.text
                }else{
                    self.createAnimation(item)
                }
            }else{
                if item.text?.characters.count > 0 {
                    password = item.text
                }else{
                    self.createAnimation(item)
                }
            }
        }
        
        guard let usr = username, pwd = password else{
            return
        }
        
        PFUser.logInWithUsernameInBackground(usr, password: pwd) { (user, error) -> Void in
            if error != nil{
                let alert = UIAlertController(title: "Login Error", message: "Incorrect Id or Password", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }else{
                print("Login success")
                let alert = UIAlertController(title: "Login Success!", message: "", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) -> Void in
                    self.dismissViewControllerAnimated(true, completion: { () -> Void in
                        self.navigationController?.popToRootViewControllerAnimated(true)
                    })
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    func createAnimation(item: UITextField) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(item.center.x - 10, item.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(item.center.x + 10, item.center.y))
        item.layer.addAnimation(animation, forKey: "position")
        return animation
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.tag == 2{
            textField.resignFirstResponder()
            login(self)
            return false
        }else{
            for item in loginTextFields{
                if item.tag == 2{
                    item.becomeFirstResponder()
                }
            }
            return false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    
    @IBAction func dismissView(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
