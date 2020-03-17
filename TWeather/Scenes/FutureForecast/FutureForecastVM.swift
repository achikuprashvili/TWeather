//
//  FutureForecastVM.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

// MARK:- Protocol

protocol FutureForecastVMProtocol {
    var screenState: BehaviorSubject<ScreenState> { get set }
    var statusMessageHandler: PublishSubject<StatusMessage> { get set }
    var didGetLocationTitle: PublishSubject<String> { get set }
    func loadForecast()
    func numberOfRows(in section: Int) -> Int
    func numberOfSections() -> Int
    func title(for section: Int) -> String
    func forecastCellVM(at indexPath: IndexPath) -> ForecastCellVM? 
}

class FutureForecastVM: MVVMViewModel {
    
    let router: MVVMRouter
    let weatherManager: WeatherManagerProtocol
    let locationManager: LocationManager
    
    var screenState = BehaviorSubject<ScreenState>(value: .loading)
    var forecast: [WeatherFullInfo] = []
    var statusMessageHandler: PublishSubject<StatusMessage> = PublishSubject<StatusMessage>()
    var didGetLocationTitle: PublishSubject<String> = PublishSubject<String>()
    var groupedForecast: [String: [WeatherFullInfo]] = [:]
    var titlesForSection: [String] = []
    let disposeBag = DisposeBag()
    
    //==============================================================================
    
    init(with router: MVVMRouter, weatherManager: WeatherManagerProtocol, locationManager: LocationManager) {
        self.router = router
        self.weatherManager = weatherManager
        self.locationManager = locationManager
    }
    
    private func groupForecastByDay(forecastList: [WeatherFullInfo]) {
        let forecastContainer: [String: [WeatherFullInfo]] = [ : ]
        groupedForecast = forecastList.reduce(into: forecastContainer) { (result, forecast) in
            result[forecast.groupDate.dateString()] = (result[forecast.groupDate.dateString()] ?? []) + [forecast]
            if !self.titlesForSection.contains(forecast.groupDate.dateString()) {
                self.titlesForSection.append(forecast.groupDate.dateString())
            }
        }

    }
    
    private func loadForecast(for location: Location) {
        self.screenState.onNext(.loading)
        weatherManager.getFiveDayForecast(lat: location.lat, long: location.lon).subscribe(onNext: { (forecast: Forecast) in
            self.groupForecastByDay(forecastList: forecast.list)
            self.screenState.onNext(.showingForecast)
        }, onError: { (error) in
            self.statusMessageHandler.onNext(error as! StatusMessage)
            self.screenState.onNext(.showingForecast)
        }).disposed(by: disposeBag)
    }
    
    private func fetchCityInfo(location: Location) {
        locationManager.fetchCityAndCountry(from: location) { (city, error) in
            guard error == nil else {
                return
            }
            var title = city ?? "Forecast"
            self.didGetLocationTitle.onNext(title)
        }
    }
    //==============================================================================
}

extension FutureForecastVM: FutureForecastVMProtocol {
    
    func numberOfRows(in section: Int) -> Int {
        if section >= titlesForSection.count {
            return 0
        }
        return groupedForecast[titlesForSection[section]]?.count ?? 0
    }
    
    func numberOfSections() -> Int {
        return groupedForecast.keys.count
    }
    
    func title(for section: Int) -> String {
        if section >= titlesForSection.count {
            return "Undefined"
        }
        return titlesForSection[section]
    }
    
    func loadForecast() {
        locationManager.getLocation().subscribe(onNext: { (location) in
            self.loadForecast(for: location)
            self.fetchCityInfo(location: location)
        }, onError: { (error) in
            let message = (error as? StatusMessage)?.localizedDescription ?? error.localizedDescription
            self.statusMessageHandler.onNext(StatusMessage.retry(message: message, retry: {
                self.loadForecast()
            }))
        }).disposed(by: disposeBag)
    }
    
    func forecastCellVM(at indexPath: IndexPath) -> ForecastCellVM? {
        guard let model = groupedForecast[titlesForSection[indexPath.section]]?[indexPath.row] else {
            return nil
        }
        let cellVM: ForecastCellVM = ForecastCellVM(from: model)
        return cellVM
    }
}

enum ScreenState {
    case loading
    case empty
    case showingForecast
}

struct ForecastCellVM {
    let icon: String
    let temp: String
    let description: String
    let time: String
    
    init(from model: WeatherFullInfo ) {
        icon = "\(Constants.WeatherApi.iconBaseUrl)/\(model.weather.first?.icon ?? "")\(Constants.WeatherApi.iconSuffix)" 
        temp = "\(model.main.temp)"
        description = model.weather.first?.description ?? "Undefined"
        time = Date(timeIntervalSince1970: TimeInterval(model.dt)).hourDateString()
    }
}
