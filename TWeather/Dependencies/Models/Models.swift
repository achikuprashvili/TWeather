//
//  Coordinate.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation

struct Coordinate: Codable {
    let lat: Double
    let long: Double
}

struct WeatherDescription: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherDetail: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct WeatherFullInfo: Codable {
    let dt: Int
    let main: WeatherDetail
    let weather: [WeatherDescription]
    let wind: Wind
    let sys: Sys?
    let name: String?
    let groupDate: Date
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dt = try values.decode(Int.self, forKey: .dt)
        main = try values.decode(WeatherDetail.self, forKey: .main)
        weather = try values.decode([WeatherDescription].self, forKey: .weather)
        wind = try values.decode(Wind.self, forKey: .wind)
        groupDate = Date(timeIntervalSince1970: TimeInterval(dt)).removeTimeStamp()
        sys = try? values.decode(Sys.self, forKey: .sys)
        name = try? values.decode(String.self, forKey: .name)
    }
}

struct Wind: Codable {
    let speed: Double
    let degree: Double
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
}

struct Forecast: Codable {
    let code: String
    let list: [WeatherFullInfo]
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case list
    }
}

struct Sys: Codable {
    let country: String?
    let sunset: Int?
    let sunrise: Int?
}
