//
//  NavigationController.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
class NavigationController: UINavigationController, UINavigationControllerDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension UINavigationController {
    
    func setTabBarItem(_ tabBarItem: TabBarItem) {
        let customTabBarItem: UITabBarItem = UITabBarItem(title: tabBarItem.title, image: UIImage(named: tabBarItem.iconName), selectedImage: UIImage(named: tabBarItem.iconNameActive))
        self.tabBarItem = customTabBarItem
    }
    
}
