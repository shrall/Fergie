//
//  DateExtension.swift
//  Fergie
//
//  Created by Marshall Kurniawan on 20/06/22.
//
//  guide: https://stackoverflow.com/questions/62664765/swift-add-n-month-to-date

import Foundation

public extension Date {
    func noon(using calendar: Calendar = .current) -> Date {
        calendar.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    func day(using calendar: Calendar = .current) -> Int {
        calendar.component(.day, from: self)
    }
    func adding(_ component: Calendar.Component, value: Int, using calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: component, value: value, to: self)!
    }
    func monthSymbol(using calendar: Calendar = .current) -> String {
        calendar.monthSymbols[calendar.component(.month, from: self)-1]
    }
    
    func dateFormatting() -> String {
            let formatterDate = DateFormatter()
            formatterDate.dateFormat = "HH:mm E, d MMM"
            if let str = formatterDate.string(for: self) {
                return str
            }
        return ""
    }
}
