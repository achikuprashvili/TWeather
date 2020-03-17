//
//  FirebaseManager.swift
//  TWeather
//
//  Created by Archil on 3/17/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol FirebaseManagerProtocol: class {
    func save(forecast: WeatherFullInfo, for location: Location)
}

class FirebaseManager: FirebaseManagerProtocol {
    private let fireStore = Firestore.firestore()
    
    func save(forecast: WeatherFullInfo, for location: Location) {
        let ref = fireStore.collection("Weather")
        guard let deviceId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKey.deviceUUID) else {
            return
        }
        let dict = ["lat": location.lat, "lon": location.lon, "forecast": forecast.dictionary!, "deviceId":  deviceId] as [String : Any]
        ref.addDocument(data: dict)
    }
}
