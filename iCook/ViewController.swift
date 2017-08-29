//
//  ViewController.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 29/09/15.
//  Copyright © 2015 Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {

    @IBOutlet var highlightBar: UIView!
    var pageController: UIPageViewController?
    var pageContent = ["Dishes", "Cooks"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "iCook"
        pageController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController
        pageController?.dataSource = self
        pageController?.delegate = self
        
        let startVC = viewControllerAtIndex(0)
        let viewControllers: NSArray = NSArray(objects: startVC)
        
        self.pageController?.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        self.pageController?.view.frame = CGRectMake(0, 100, self.view.frame.width, self.view.frame.height - 30)
        self.addChildViewController(self.pageController!)
        self.view.addSubview((self.pageController?.view)!)
        self.pageController?.didMoveToParentViewController(self)
        
        
    }
    

    func updateMenuHiglight(update: Bool){
        if update{
            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: .TransitionCurlDown, animations: { () -> Void in
                self.highlightBar.frame.origin.x += 160
                }, completion: nil)
        }else{
            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: .TransitionCurlDown, animations: { () -> Void in
                self.highlightBar.frame.origin.x -= 160
                }, completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewControllerAtIndex(index: Int) -> PageContentViewController{
        if (pageContent.count == 0) || (index >= pageContent.count){
            return PageContentViewController()
        }
        
        let dataViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("PageContentView") as! PageContentViewController
        dataViewController.pageIndex = index

        return dataViewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! PageContentViewController
        var index = vc.pageIndex
        
        updateMenuHiglight(false)
        if (index == 0) || (index == NSNotFound){
            return nil
        }
        index!--
        
        return self.viewControllerAtIndex(index!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

        let vc = viewController as! PageContentViewController
        var index = vc.pageIndex
        
        updateMenuHiglight(true)
        if (index == NSNotFound){
            return nil
        }
        
        index!++

        if (index == pageContent.count){
            return nil
        }
        
        return viewControllerAtIndex(index!)
    }

}

