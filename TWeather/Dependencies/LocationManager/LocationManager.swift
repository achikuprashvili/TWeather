//
//  LocationManager.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

enum LocationManagerErrors: Int {
    case AuthorizationDenied
    case AuthorizationNotDetermined
    case InvalidLocation
}

typealias Location = (lat: Double, lon: Double)

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    fileprivate var observer: AnyObserver<Location>?
    
    func getLocation() -> Observable<Location> {
        
        return Observable<Location>.create { observer in
            self.observer = observer
            
            let authorizationStatus = CLLocationManager.authorizationStatus()
            
            switch authorizationStatus {
            case .notDetermined:
                self.manager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                self.startUpdatingLocation()
            default:
                observer.onError(StatusMessage.locationManager(message: "TWeather needs your location to show forecast", retry: nil))
            }
            
            return Disposables.create { }
        }
    }
    
    private let manager: CLLocationManager = {
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.activityType = .other
        return $0
    }(CLLocationManager())
    
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        observer = nil
        manager.stopUpdatingLocation()
    }
    
    // MARK: Location Updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let validLocation = Location(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            observer?.onNext(validLocation)
        } else {
            observer?.onError(StatusMessage.locationManager(message: "Check you network connection", retry: nil))
        }
        stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        observer?.onError(StatusMessage.locationManager(message: error.localizedDescription, retry: nil))
        stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            startUpdatingLocation()
        } else {
            observer?.onError(StatusMessage.locationManager(message: "TWeather needs your location to show forecast", retry: nil))
            stopUpdatingLocation()
        }
    }
    
    func fetchCityAndCountry(from location: Location, completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        let cLocation = CLLocation(latitude: location.lat, longitude: location.lon)
        CLGeocoder().reverseGeocodeLocation(cLocation) { placemarks, error in
            completion(placemarks?.first?.locality,
                       error)
        }
    }
}
