//
//  ContainerViewController.swift
//  SplitAndPopover
//
//  Created by Tomohiro Mitsumune on 2015/04/23.
//  Copyright (c) 2015年 tmitsumune. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    var viewController: UISplitViewController!
    
    func setEmbeddedViewController(splitViewController: UISplitViewController?) {
        if splitViewController != nil {
            viewController = splitViewController!
            
            addChildViewController(viewController)
            view.addSubview(viewController.view)
            viewController.didMoveToParentViewController(self)
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.Regular {
            setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: .Regular), forChildViewController: viewController)
        } else {
            setOverrideTraitCollection(nil, forChildViewController: viewController)
        }
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
