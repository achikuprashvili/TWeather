//
//  AppDelegate.swift
//  TWeather
//
//  Created by Archil on 3/15/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let coordinator = Coordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
            // Check SceneDelegate
        } else {
            coordinator.presentInitialScreen(on: UIWindow())
        }

        return true
    }

}
