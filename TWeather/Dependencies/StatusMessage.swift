//
//  StatusMessage.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation

enum StatusMessage: Error {
    case error(message: String)
    case networkError(message: String)
    case parsError
    case unknown(message: String)
    case serverError(message: String, code: Int?)
    case serverSuccess(message: String)
    case warning(message: String)
    case retry(message: String, retry: () -> Void)
    case locationManager(message: String, retry: (() -> Void)?)
    
    var title: String {
        switch self {
        case .networkError:
            return "networkError"
        case .parsError:
            return "serverEerror"
        case .unknown:
            return ""
        case .serverError, .serverSuccess, .warning, .retry, .error, .locationManager:
            return ""
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .error(let message):
            return message
        case .networkError(let message):
            return message
        case .parsError:
            return "incorrect server response"
        case .unknown(let message):
            return message
        case .serverError(let message, _):
            return message
        case .serverSuccess(let message):
            return message
        case .warning(let message), .retry(let message, _):
            return message
        case .locationManager(let message, _):
            return message
        }
    }
    
    var isSuccess: Bool {
        switch self {
        case .serverSuccess:
            return true
        default:
            return false
        }
    }
    
    var code: Int {
        switch self {
        case .serverError(_, let code):
            return code ?? 0
        default:
            return 0
        }
    }
}
