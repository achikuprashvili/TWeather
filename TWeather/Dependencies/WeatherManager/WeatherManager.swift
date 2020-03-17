//
//  WeatherManager.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol WeatherManagerProtocol: class {
    init(backendManager: BackendManagerProtocol)
    
    func getFiveDayForecast<T: Codable>(lat: Double, long: Double) -> Observable<T>
    func getTodaysForecast<T: Codable>(lat: Double, long: Double) -> Observable<T>
}

class WeatherManager: WeatherManagerProtocol{

    var backendManager: BackendManagerProtocol
    
    required init(backendManager: BackendManagerProtocol) {
        self.backendManager = backendManager
    }
    
    func getFiveDayForecast<T>(lat: Double, long: Double) -> Observable<T> where T : Codable {
        backendManager.sendRequest(WeatherRequestRouter.getFiveDayForecast(lat: lat, long: long))
    }
    
    func getTodaysForecast<T>(lat: Double, long: Double) -> Observable<T> where T : Codable {
        backendManager.sendRequest(WeatherRequestRouter.getTodaysForecast(lat: lat, long: long))
    }
}
