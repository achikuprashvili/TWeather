//
//  TodaysForecastRouter.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation
import UIKit

class TodaysForecastRouter: MVVMRouter {
    
    enum PresentationContext {
        case fromTabBar
    }
    
    enum RouteType {
        
    }
    
    weak var baseViewController: UIViewController?
    let dependencies: AppDependencies
    
    //==============================================================================
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    //==============================================================================
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
        guard let presentationContext = context as? PresentationContext else {
            assertionFailure("The context type missmatch")
            return
        }
        
        guard let nc = baseVC as? UINavigationController else {
            assertionFailure("The baseVC should be UINavigationController")
            return
        }
        baseViewController = baseVC
        
        let vc = TodaysForecastVC.instantiateFromStoryboard(storyboardName: "TodaysForecast", storyboardId: "TodaysForecastVC")
        let viewModel = TodaysForecastVM.init(with: self, weatherManager: dependencies.weatherManager, locationManager: dependencies.locationManager, firebaseManager: dependencies.firebaseManager)
        vc.viewModel = viewModel
        
        switch presentationContext {
        case .fromTabBar:
            nc.pushViewController(vc, animated: animated)
        }
    }
    
    //==============================================================================
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
        guard let routeType = context as? RouteType else {
            assertionFailure("The route type missmatches")
            return
        }
        
        guard let nc = baseViewController as? UINavigationController else {
            assertionFailure("The baseVC should be UINavigationController")
            return
        }
        
        switch routeType {
            
        }
    }
    
    //==============================================================================
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        guard let nc = baseViewController as? UINavigationController else {
            assertionFailure("The baseVC should be UINavigationController")
            return
        }
        nc.popViewController(animated: true)
    }
    
    //==============================================================================
}
