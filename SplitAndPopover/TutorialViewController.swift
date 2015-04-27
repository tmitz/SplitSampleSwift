//
//  TutorialViewController.swift
//  SplitAndPopover
//
//  Created by Tomohiro Mitsumune on 2015/04/23.
//  Copyright (c) 2015年 tmitsumune. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var pubDateButtonItem: UIBarButtonItem!
    
    @IBAction func showPublishDate(sender: AnyObject) {
        var popoverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idPopoverViewController") as! PopoverViewController
        popoverViewController.modalPresentationStyle = .Popover
        popoverViewController.popoverPresentationController?.delegate = self
        
        presentViewController(popoverViewController, animated: true, completion: nil)
        popoverViewController.popoverPresentationController?.barButtonItem = pubDateButtonItem
        popoverViewController.popoverPresentationController?.permittedArrowDirections = .Any
        popoverViewController.preferredContentSize = CGSizeMake(200.0, 80.0)
        
        popoverViewController.lblMessage.text = "Publish Date: \n\(publishDate)"
    }
    
    var tutorialURL: NSURL!
    var tutorialButtonItem: UIBarButtonItem!
    var publishDate: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.hidden = true
        toolbar.hidden = true
        tutorialButtonItem = UIBarButtonItem(title: "Tutorial", style: .Plain, target: self, action: "showTutorialsViewController")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleFirstViewControllerDisplayModeChangeWithNotification:", name: "primaryVCDisplayModeChangeNotification", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if tutorialURL != nil {
            let request = NSURLRequest(URL: tutorialURL)
            webView.loadRequest(request)
            
            if webView.hidden {
                webView.hidden = false
                toolbar.hidden = false
            }

            if traitCollection.verticalSizeClass == .Compact {
                println(tutorialButtonItem)
                toolbar.items?.insert(splitViewController!.displayModeButtonItem(), atIndex: 0)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showTutorialsViewController() {
        splitViewController?.preferredDisplayMode = .AllVisible
    }
    
    func handleFirstViewControllerDisplayModeChangeWithNotification(notification: NSNotification) {
        let displayModeObject = notification.object as! NSNumber
        let nextDisplayMode = displayModeObject.integerValue
        
        if toolbar.items?.count == 3 {
            toolbar.items?.removeAtIndex(0)
        }
        
        if nextDisplayMode == UISplitViewControllerDisplayMode.PrimaryHidden.rawValue {
            toolbar.items?.insert(tutorialButtonItem, atIndex: 0)
        } else {
            toolbar.items?.insert(splitViewController!.displayModeButtonItem(), atIndex: 0)
        }
        
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.verticalSizeClass == .Compact {
            let firstItem = toolbar.items?[0] as? UIBarButtonItem
            if firstItem?.title == "Tutorial" {
                toolbar.items?.removeAtIndex(0)
            }
        } else if previousTraitCollection?.verticalSizeClass == .Regular {
            if toolbar.items?.count == 3 {
                toolbar.items?.removeAtIndex(0)
            }
            
            if splitViewController?.displayMode == .PrimaryHidden {
                toolbar.items?.insert(tutorialButtonItem, atIndex: 0)
            } else {
                toolbar.items?.insert(splitViewController!.displayModeButtonItem(), atIndex: 0)
            }
        }
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
