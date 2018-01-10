//
//  PaiCalendar.swift
//  Pai
//
//  Created by Luqman Fauzi on 26/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import Foundation

private let calendar = Calendar.autoupdatingCurrent
private let currentDate = Date()

public struct PaiDate {
    let date: Date
}

public enum Month: Int {
    case jan, feb, mar, apr, may, jun, jul, aug, sept, oct, nov, dec
}

public enum Day: Int {
    case mon, tue, wed, thu, fri, sat, sun
}

public enum DateItemStyle {
    case normal, excluded
}

internal class PaiCalendar {

    public static let current = PaiCalendar()
    private init() { }

    public var shortMonthSymbols: [String] {
        return calendar.shortMonthSymbols
    }

    public var veryShortWeekdaySymbols: [String] {
        return calendar.veryShortWeekdaySymbols
    }

    public var currentMonth: Int {
        return calendar.component(.month, from: currentDate)
    }

    public var currentYear: Int {
        return calendar.component(.year, from: currentDate)
    }

    public var monthsOfYearCount: Int {
        let dateComponents = DateComponents(year: currentYear)
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .month, in: .year, for: date)!
        let monthsCount = range.count
        return monthsCount
    }

    // MARK: - Days in Month

    private func date(inMonth month: Month) -> Date {
        var components = DateComponents()
        components.month = month.rawValue
        return calendar.date(byAdding: components, to: currentDate) ?? Date()
    }

    private func startDate(inMonth month: Month) -> Date {
        let particularDateInMonth = date(inMonth: month)
        var components = calendar.dateComponents([.year, .month, .day], from: particularDateInMonth)
        components.day = 1
        return calendar.date(from: components) ?? Date()
    }

    public func indexStartDate(inMonth month: Month) -> Int? {
        let date = startDate(inMonth: month)
        if let index = calendar.ordinality(of: .day, in: .weekOfMonth, for: date) {
            return index - 1
        }
        return nil
    }

    public func indexEndDate(inMonth month: Month) -> Int? {
        let date = startDate(inMonth: month)
        let startIndex = indexStartDate(inMonth: month)
        if let rangeDays = calendar.range(of: .day, in: .month, for: date), let beginning = startIndex {
            let count = rangeDays.upperBound - rangeDays.lowerBound
            return count + beginning - 1
        }
        return nil
    }

    public func datesCountInMonth(inMonth month: Month) -> [PaiDate] {
        guard let startIndex = indexStartDate(inMonth: month) else {
            fatalError("Index not found")
        }
        var components = DateComponents()
        let count = numberOfCells(inMonth: month)
        let dates: [PaiDate] = (0..<count).flatMap { index in
            components.day = index - startIndex
            return calendar.date(byAdding: components, to: startDate(inMonth: month))
        }.map {
            return PaiDate(date: $0)
        }
        return dates
    }

    public func numberOfCells(inMonth month: Month) -> Int {
        if let weeksRange = calendar.range(of: .weekOfMonth, in: .month, for: startDate(inMonth: month)) {
            let count = weeksRange.upperBound - weeksRange.lowerBound
            return count * 7
        }
        return 0
    }
}
