//
//  PaiCalendarDelegate.swift
//  Pai
//
//  Created by Luqman Fauzi on 11/01/2018.
//  Copyright © 2018 Luqman Fauzi. All rights reserved.
//

import Foundation

public protocol PaiCalendarDataSource: class {

    /// List of `[PaiDateEvent]` events to be displayed in calendar
    ///
    /// - Parameter calendar: `MonthCollectionView`
    /// - Returns: list of all events to be displayed in the calendar view
    func calendarDateEvents(in calendar: MonthCollectionView) -> [PaiDateEvent]
}

public extension PaiCalendarDataSource {
    func calendarDateEvents(in calendar: MonthCollectionView) -> [PaiDateEvent] {
        return []
    }
}

public protocol PaiCalendarDelegate: class {

    /// Send event on tapping specific date in month
    ///
    /// - Parameters:
    ///   - calendar: `MonthCollectionView`
    ///   - index: index of selected date in particular month
    ///   - date: selected `PaiDate` in particular month
    func calendarDateDidSelect(in calendar: MonthCollectionView, at index: Int, date: PaiDate)

    /// Send month string when month cell is currently at top of screen
    ///
    /// - Parameters:
    ///   - calendar: `MonthCollectionView`
    ///   - index: index of selected month
    ///   - month: string of selected month
    ///   - year: string of selected year
    func calendarMonthViewDidScroll(in calendar: MonthCollectionView, at index: Int, month: String, year: String)

    /// Send month string when month cell is currently at top of screen
    ///
    /// - Parameters:
    ///   - calendar: `MonthCollectionView`
    ///   - datesString: array of formattable date string of current visible month [yyyy-MM-dd]
    func calendarMonthVisibleMonth(in calendar: MonthCollectionView, datesString: [String])
}

public extension PaiCalendarDelegate {
    func calendarDateDidSelect(in calendar: MonthCollectionView, at index: Int, date: PaiDate) { }
    func calendarMonthViewDidScroll(in calendar: MonthCollectionView, at index: Int, month: String, year: String) { }
    func calendarMonthVisibleMonth(in calendar: MonthCollectionView, datesString: [String]) { }
}
