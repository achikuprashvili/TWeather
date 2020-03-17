//
//  WeatherRequestRouter.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation
import Alamofire

enum WeatherRequestRouter: RequestRouter {
    case getFiveDayForecast(lat: Double, long: Double)
    case getTodaysForecast(lat: Double, long: Double)
    
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getFiveDayForecast(_, _):
            return "data/2.5/forecast"
        case .getTodaysForecast(_, _):
            return "data/2.5/weather"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getFiveDayForecast(let lat, let long):
            let params: [String : Any] = ["lat": lat, "lon": long, "units": "metric", "appid": Constants.WeatherApi.key]
            return params
        case .getTodaysForecast(let lat, let long):
            let params: [String : Any] = ["lat": lat, "lon": long, "units": "metric", "appid": Constants.WeatherApi.key]
            return params
        }
    }
}
