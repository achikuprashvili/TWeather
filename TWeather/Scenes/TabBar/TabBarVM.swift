//
//  TabBarVM.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation

// MARK:- Protocol

protocol TabBarVMProtocol {
    
}

class TabBarVM: MVVMViewModel {
    
    let router: MVVMRouter
    let dependencies: AppDependencies
    
    //==============================================================================
    
    init(with router: MVVMRouter, dependencies: AppDependencies) {
        self.router = router
        self.dependencies = dependencies
    }
    
    func setViewContollers(_ tabBarVC: TabBarVC) {
        
        let todaysForecastRouter = TodaysForecastRouter(dependencies: dependencies)
        let todaysForecastPresentationContext = TodaysForecastRouter.PresentationContext.fromTabBar
        let todaysForecastNC = NavigationController()
        todaysForecastRouter.present(on: todaysForecastNC, animated: true, context: todaysForecastPresentationContext, completion: nil)
        todaysForecastNC.setTabBarItem(.todaysForecast)
        
        let futureForecastRouter = FutureForecastRouter(dependencies: dependencies)
        let futureForecastContext = FutureForecastRouter.PresentationContext.fromTabBar
        let futureForecastNC = NavigationController()
        futureForecastRouter.present(on: futureForecastNC, animated: true, context: futureForecastContext, completion: nil)
        futureForecastNC.setTabBarItem(.futureForecast)

        tabBarVC.setViewControllers([todaysForecastNC, futureForecastNC], animated: false)
    }
    
    //==============================================================================
}

extension TabBarVM: TabBarVMProtocol {
    
}
