//
//  Constants.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation

struct Constants {
    struct WeatherApi {
        static let key = "ef976be38c515abd9d7fea1654e1685e"
        static let baseURL = "http://api.openweathermap.org"
        static let iconBaseUrl = "http://openweathermap.org/img/wn/"
        static let iconSuffix = "@2x.png"
    }
    
    struct UserDefaultsKey {
        static let isFirstRun = "TWeather_isFirstRun"
        static let deviceUUID = "TWeather_deviceUUID"
    }
    
    static let activityIndicatorTag = 100
}
