//
//  TabBarController.swift
//  SportEventScheduler
//
//  Created by Mirzhan Gumarov on 12/3/17.
//  Copyright © 2017 Mirzhan Gumarov. All rights reserved.
//

import UIKit


class TabBarController: UITabBarController {
    
    let sportEventTableViewController = SportEventListViewController()
    let profileViewController = ProfileViewController() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sportEventTableViewController.tabBarItem = UITabBarItem(title: "Events", image: #imageLiteral(resourceName: "list"), tag: 0)
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "user"), tag: 1)
        
        let viewControllerList = [sportEventTableViewController, profileViewController]
        
        viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
    }
}
