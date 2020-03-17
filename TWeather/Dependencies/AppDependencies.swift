//
//  AppDependencies.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation

struct AppDependencies {
    let weatherManager: WeatherManagerProtocol
    let locationManager: LocationManager
    let firebaseManager: FirebaseManagerProtocol
    
    init() {
        let backendManager = BackendManager()
        weatherManager = WeatherManager(backendManager: backendManager)
        locationManager = LocationManager()
        firebaseManager = FirebaseManager()
    }
}
