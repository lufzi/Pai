//
//  PaiCalendar.swift
//  Pai
//
//  Created by Luqman Fauzi on 26/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import Foundation

public class PaiCalendar {

    public static let current = PaiCalendar()
    private init() { }

    private let calendar = Calendar.autoupdatingCurrent
    private let today = Date()

    public var shortMonthSymbols: [String] {
        return calendar.shortMonthSymbols
    }

    public var veryShortWeekdaySymbols: [String] {
        return calendar.veryShortWeekdaySymbols
    }
}

public extension PaiCalendar {

    // MARK: - Days in Month, UI related

    /// Construct the `[PaiDate]` list of a particular month & year according to `[DayViewCell]` scope.
    ///
    /// - Parameter month: `PaiMonth` which contains month & year values.
    /// - Returns: list of `[PaiDate]` of given month & year.
    public func datesCountInMonth(inMonth month: PaiMonth) -> [PaiDate] {
        guard let startIndex = indexStartDate(inMonth: month) else {
            fatalError("Index not found")
        }
        let date = startDate(inMonth: month)
        let count = numberOfItemMonthCells(inMonth: month)
        let dates: [PaiDate] = (0..<count).flatMap { index in
            var components = DateComponents()
            components.day = index - startIndex
            return calendar.date(byAdding: components, to: date)
        }.map {
            return PaiDate(date: $0)
        }
        return dates
    }

    /// Get the maximum capacity of `[DayViewCell]` list in the `MonthViewCell` content.
    ///
    /// - Parameter month: `PaiMonth` which contains month & year values.
    /// - Returns: the number of maximum count.
    public func numberOfItemMonthCells(inMonth month: PaiMonth) -> Int {
        if let weeksRange = calendar.range(of: .weekOfMonth, in: .month, for: startDate(inMonth: month)) {
            let count = weeksRange.upperBound - weeksRange.lowerBound
            return count * 7
        }
        return 0
    }

    // MARK: - Days in Month, data related

    /// Get the starting date of particular month & year
    ///
    /// - Parameter month: `PaiMonth` which contains month & year values.
    /// - Returns: the first `Date` of particular month & year.
    private func startDate(inMonth month: PaiMonth) -> Date {
        var components = calendar.dateComponents([.year, .month, .day], from: today)
        components.day = 1
        components.month = month.month.rawValue + 1
        components.year = month.year
        return calendar.date(from: components) ?? Date()
    }

    /// Get the index value of first `Date` of particular month & year in the `MonthViewCell` content / `[DayViewCell]` list.
    /// In order to set the date month opening 'edge' date of the month.
    /// - Parameter month: `PaiMonth` which contains month & year values.
    /// - Returns: `Int` index value of the first date of particular onth & year values.
    public func indexStartDate(inMonth month: PaiMonth) -> Int? {
        let date = startDate(inMonth: month)
        if let index = calendar.ordinality(of: .day, in: .weekOfMonth, for: date) {
            return index - 1
        }
        return nil
    }

    /// Get the index value of last `Date` of particular month & year in the `MonthViewCell` content / `[DayViewCell]`.
    /// In order to set the date month closure 'edge' date of the month.
    /// - Parameter month: `PaiMonth` which contains month & year values.
    /// - Returns: `Int` index value of the first date of particular onth & year values.
    public func indexEndDate(inMonth month: PaiMonth) -> Int? {
        let date = startDate(inMonth: month)
        let startIndex = indexStartDate(inMonth: month)
        if let rangeDays = calendar.range(of: .day, in: .month, for: date), let beginning = startIndex {
            let count = rangeDays.upperBound - rangeDays.lowerBound
            return count + beginning - 1
        }
        return nil
    }
}
