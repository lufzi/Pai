//
//  PaiMonthEvent.swift
//  Pai
//
//  Created by augustius cokroe on 23/03/2018.
//

import Foundation

public struct PaiMonthEvent {

    public let monthYearStr: String // yyyy M

    public let monthEvents: [PaiDateEvent]

    /// Initlizer of the struct
    ///
    /// - Parameters:
    ///   - monthYearStr: date of event in `yyyy M` format
    ///   - monthEvents: array of PaiDateEvent object
    public static func initObject(monthYearStr: String, monthEvents: [PaiDateEvent]) -> PaiMonthEvent {
        return PaiMonthEvent(monthYearStr: monthYearStr, monthEvents: monthEvents)
    }
}

public extension PaiMonthEvent {
    /// Generate random events
    ///
    /// - Parameters:
    ///   - numberOfEvents: `Date` of event
    ///   - numberOfDays: `[UIColor]` array of tag color
    ///   - monthYearArr: `[String]` array of string of date with format `yyyy M`
    public static func generateRandom(numberOfEvents: Int, numberOfDays: Int, monthYearArr: [String]) -> [PaiMonthEvent] {

        /// get array of color for each day
        var tagColors = [UIColor]()
        for i in 1...numberOfEvents {
            let color: UIColor = (i % 2 == 0) ? .red : .blue
            tagColors.append(color)
        }

        /// get array of PaiMonthEvent with events
        var monthEvents: [PaiMonthEvent] = []
        let secondsInDays: TimeInterval = 60 * 60 * 24
        for (index,str) in monthYearArr.enumerated() {
            var dayEvents: [PaiDateEvent] = []
            for day in 1...numberOfDays {
                var date = Date().addingTimeInterval(Double(day - 1) * secondsInDays)
                date = Calendar.current.date(byAdding: .month, value: index, to: date) ?? Date()
                let event = PaiDateEvent(date: date, tagColors: tagColors)
                dayEvents.append(event)
            }
            let mEvent = PaiMonthEvent.initObject(monthYearStr: str, monthEvents: dayEvents)
            monthEvents.append(mEvent)
        }

        return monthEvents
    }
}


