//
//  BackendManager.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

protocol BackendManagerProtocol {
    func sendRequest<T: Codable>(_ router: RequestRouter) -> Observable<T>
}

class BackendManager: BackendManagerProtocol {
    func sendRequest<T>(_ router: RequestRouter) -> Observable<T> where T : Codable {
        return Observable<T>.create { observer in
            let request = AF.request(router)
            
            request.validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let decodeObject = try JSONDecoder().decode(T.self, from: jsonData)
                        observer.onNext(decodeObject)
                    } catch {
                        observer.onError(StatusMessage.parsError)
                    }
                case .failure(let error):
                    observer.onError(StatusMessage.networkError(message: error.localizedDescription))
                }
            }
            return Disposables.create{
                request.cancel()
            }
        }
    }
}
