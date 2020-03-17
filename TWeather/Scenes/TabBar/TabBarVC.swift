
//
//  TabBarVC.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

enum TabBarItem: String, CaseIterable {
    case futureForecast
    case todaysForecast
    
    var iconName: String {
        return rawValue
    }
    
    var iconNameActive: String {
        return rawValue + "Ac"
    }
    
    var title: String {
        switch self {
        case .todaysForecast:
            return "Today"
        case .futureForecast:
            return "Forecast"
        }
    }
}

class TabBarVC: UITabBarController, MVVMViewController, UITabBarControllerDelegate {
    var viewModel: TabBarVMProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 0
        self.tabBar.isTranslucent = false
        view.backgroundColor = UIColor.AppColor.backgroundColor
    }
}

