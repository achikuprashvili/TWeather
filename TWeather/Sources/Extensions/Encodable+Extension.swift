//
//  Encodable+Extension.swift
//  TWeather
//
//  Created by Archil on 3/17/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
