//
//  PaiCalendarDelegate.swift
//  Pai
//
//  Created by Luqman Fauzi on 11/01/2018.
//  Copyright © 2018 Luqman Fauzi. All rights reserved.
//

import Foundation

public protocol PaiCalendarDelegate: class {

    /// Send event on tapping specific date in month
    ///
    /// - Parameters:
    ///   - calendar: `MonthCollectionView`
    ///   - index: index of selected date in particular month
    ///   - date: selected `PaiDate` in particular month
    func calendarDateDidSelect(in calendar: MonthCollectionView, at index: Int, date: PaiDate)
}

extension PaiCalendarDelegate {
    func calendarDateDidSelect(in calendar: MonthCollectionView, at index: Int, date: PaiDate) { }
}
