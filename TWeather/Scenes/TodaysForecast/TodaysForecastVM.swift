//
//  TodaysForecastVM.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK:- Protocol

protocol TodaysForecastVMProtocol {
    var screenState: BehaviorSubject<ScreenState> { get set }
    var statusMessageHandler: PublishSubject<StatusMessage> { get set }
    var didGetForecast: PublishSubject<WeatherFullInfo> { get set }
    func loadForecast()
}

class TodaysForecastVM: MVVMViewModel {
    
    let router: MVVMRouter
    let weatherManager: WeatherManagerProtocol
    let locationManager: LocationManager
    let firebaseManager: FirebaseManagerProtocol
    
    
    var screenState = BehaviorSubject<ScreenState>(value: .loading)
    var didGetForecast: PublishSubject<WeatherFullInfo> = PublishSubject<WeatherFullInfo>()
    var statusMessageHandler: PublishSubject<StatusMessage> = PublishSubject<StatusMessage>()
    let disposeBag = DisposeBag()
     //==============================================================================
    
    init(with router: MVVMRouter, weatherManager: WeatherManagerProtocol, locationManager: LocationManager, firebaseManager: FirebaseManagerProtocol) {
        self.router = router
        self.weatherManager = weatherManager
        self.locationManager = locationManager
        self.firebaseManager = firebaseManager
    }
    
    private func loadForecast(for location: Location) {
        self.screenState.onNext(.loading)
        weatherManager.getTodaysForecast(lat: location.lat, long: location.lon).subscribe(onNext: { (forecast: WeatherFullInfo) in
            self.screenState.onNext(.showingForecast)
            self.didGetForecast.onNext(forecast)
            self.saveForecastInFirebase(forecast: forecast, location: location)
        }, onError: { (error) in
            self.statusMessageHandler.onNext(error as! StatusMessage)
            self.screenState.onNext(.showingForecast)
        }).disposed(by: disposeBag)
    }
    
    private func saveForecastInFirebase(forecast: WeatherFullInfo, location: Location) {
        firebaseManager.save(forecast: forecast, for: location)
    }
    
    //==============================================================================
}

extension TodaysForecastVM: TodaysForecastVMProtocol {
    func loadForecast() {
        locationManager.getLocation().subscribe(onNext: { (location) in
            self.loadForecast(for: location)
        }, onError: { (error) in
            let message = (error as? StatusMessage)?.localizedDescription ?? error.localizedDescription
            self.statusMessageHandler.onNext(StatusMessage.retry(message: message, retry: {
                self.loadForecast()
            }))
        }).disposed(by: disposeBag)
    }
}
