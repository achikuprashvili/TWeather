//
//  RequestRouter.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestRouter: URLRequestConvertible {
    
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

extension RequestRouter {
    
    func asURLRequest() throws -> URLRequest {
        
        var url = try Constants.WeatherApi.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
    
}
