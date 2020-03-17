//
//  Coordinator.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Coordinator {
    
    var dependencies: AppDependencies
    var window: UIWindow?
    var navigationController: UINavigationController
    
    //==============================================================================
    
    init() {
        FirebaseApp.configure()
        navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        dependencies = AppDependencies()
        
        if isFirstRun() {
            UserDefaults.standard.set(UUID().uuidString, forKey: Constants.UserDefaultsKey.deviceUUID)
        }
    }
    
    func isFirstRun() -> Bool {
        if !UserDefaults.standard.bool(forKey: Constants.UserDefaultsKey.isFirstRun) {
            UserDefaults.standard.set(true, forKey: Constants.UserDefaultsKey.isFirstRun)
            return true
        }
        return false
    }
    //==============================================================================
    
    func presentInitialScreen(on window: UIWindow) {
        self.window = window
        window.rootViewController = navigationController
        let tabBarRouter = TabBarRouter(dependencies: dependencies)
        let presentationContex = TabBarRouter.PresentationContext.fromCoordinator
        tabBarRouter.present(on: navigationController, animated: true, context: presentationContex, completion: nil)
        window.makeKeyAndVisible()
    }
}
