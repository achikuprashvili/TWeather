//
//  TabBarRouter.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation
import UIKit

class TabBarRouter: MVVMRouter {
    
    enum PresentationContext {
        case fromCoordinator
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
        
        let vc = TabBarVC.instantiateFromStoryboard(storyboardName: "TabBar", storyboardId: "TabBarVC")
        let viewModel = TabBarVM.init(with: self, dependencies: dependencies)
        vc.viewModel = viewModel
        viewModel.setViewContollers(vc)
        
        switch presentationContext {
        
        case .fromCoordinator:
            nc.pushViewController(vc, animated: true)
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
