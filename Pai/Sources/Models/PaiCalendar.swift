//
//  PaiCalendar.swift
//  Pai
//
//  Created by Luqman Fauzi on 26/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import Foundation

internal class PaiCalendar {

    private let calendar = Calendar.autoupdatingCurrent
    private let date = Date()

    public static let current = PaiCalendar()

    private init() { }

    public var monthsOfYearCount: Int {
        return calendar.component(.month, from: date)
    }

    public var weeksOfMonths: Int {
        return calendar.component(.weekOfMonth, from: date)
    }

    public var monthSymbols: [String] {
        return calendar.monthSymbols
    }

    public var shortMonthSymbols: [String] {
        return calendar.shortMonthSymbols
    }

    public var weekdaySymbols: [String] {
        return calendar.weekdaySymbols
    }

    public var veryShortWeekdaySymbols: [String] {
        return calendar.veryShortWeekdaySymbols
    }

    public var dateOfMonthSymbols: [String] = {
        var dates: [Int] = []
        for number in 0...30 {
            dates.append(number)
        }
        return dates.map({ $0.description })
    }()
}
