//
//  Date+Extension.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation

extension Date {
    public func removeTimeStamp() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        guard let date = calendar.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            fatalError("Failed to strip time from Date object")
        }
        return date
    }
    
    public func dateString() -> String {
        let formatterForOlrderDate = DateFormatter()
        formatterForOlrderDate.dateFormat = "dd.MM.yy"
    
        if Calendar.current.isDateInTomorrow(self) {
            return "Tomorrow"
        } else if Calendar.current.isDateInToday(self) {
            return "Today"
        } else {
            return formatterForOlrderDate.string(from: self)
        }
    }
    
    public func hourDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a" // "a" prints "pm" or "am"
        return formatter.string(from: self)
    }
}
