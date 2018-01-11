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
}

public extension PaiCalendarDelegate {
    func calendarDateDidSelect(in calendar: MonthCollectionView, at index: Int, date: PaiDate) { }
}
