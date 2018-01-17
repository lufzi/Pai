//
//  PaiMonth.swift
//  Pai
//
//  Created by Luqman Fauzi on 11/01/2018.
//  Copyright © 2018 Luqman Fauzi. All rights reserved.
//

import Foundation

public enum Month: Int {
    case jan, feb, mar, apr, may, jun, jul, aug, sept, oct, nov, dec
}

public struct PaiMonth {
    let year: Int
    let symbol: String
    let month: Month
}

public extension PaiMonth {

    /// Generates all the months within particular range of years.
    ///
    /// - Parameters:
    ///   - startYear: starting year
    ///   - endYear: end year
    /// - Returns: list of `[PaiMonth]`
    static func generatesInYears(from startYear: Int, to endYear: Int) -> [PaiMonth] {
        guard endYear >= startYear else {
            fatalError("The end year must be greater than or equal to start year.")
        }
        var months: [PaiMonth] = []
        for year in startYear...endYear {
            for (index, symbol) in Calendar.autoupdatingCurrent.shortMonthSymbols.enumerated() {
                let month = Month(rawValue: index)!
                let paiMonth = PaiMonth(year: year, symbol: symbol, month: month)
                months.append(paiMonth)
            }
        }
        return months
    }
 
    /// Generates all the months within backward & forward range of months.
    ///
    /// - Parameters:
    ///   - backwardsCount: the number of months backward from now.
    ///   - forwardsCount: the number of months forward from now.
    /// - Returns: list of `[PaiMonth]`
    static func generatesInMonts(backwardsCount: Int, forwardsCount: Int) -> [PaiMonth] {
        let calendar = Calendar.autoupdatingCurrent
        let setComponents: Set<Calendar.Component> = [.year, .month, .day]
        let monthSymbols: [String] = calendar.monthSymbols
        let today = Date()
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"

        var backwardsDateComponent = calendar.dateComponents(setComponents, from: today)
        var forwardsDateComponent = calendar.dateComponents(setComponents, from: today)
        let currentDateComponent = calendar.dateComponents(setComponents, from: today)
        let currentMonth = currentDateComponent.month!

        backwardsDateComponent.month = currentMonth - backwardsCount
        forwardsDateComponent.month = currentMonth + forwardsCount

        let firstDate = calendar.date(from: backwardsDateComponent)!
        let firstMonthOrdinaly = calendar.ordinality(of: .month, in: .year, for: firstDate)!
        let firstYear = Int(yearFormatter.string(from: firstDate))!

        let lastDate = calendar.date(from: forwardsDateComponent)!
        let lastMonthOrdinaly = calendar.ordinality(of: .month, in: .year, for: lastDate)!
        let lastYear = Int(yearFormatter.string(from: lastDate))!

        var monthsInYears: [PaiMonth] = []

        for year in firstYear...lastYear {
            if year == firstYear {
                /// Left edge year
                let months: [PaiMonth] = Array(firstMonthOrdinaly...monthSymbols.count).enumerated().flatMap({
                    let index = $0.element - 1
                    let month = Month(rawValue: index)!
                    let symbol = monthSymbols[index]
                    let paiMonth = PaiMonth(year: year, symbol: symbol, month: month)
                    return paiMonth
                })
                monthsInYears.append(contentsOf: months)
            } else if year == lastYear {
                /// Right edge year
                let months: [PaiMonth] = Array(1...lastMonthOrdinaly).enumerated().flatMap({
                    let index = $0.element - 1
                    let month = Month(rawValue: index)!
                    let symbol = monthSymbols[index]
                    let paiMonth = PaiMonth(year: year, symbol: symbol, month: month)
                    return paiMonth
                })
                monthsInYears.append(contentsOf: months)
            } else {
                let months: [PaiMonth] = monthSymbols.enumerated().flatMap({
                    let month = Month(rawValue: $0.offset)!
                    let paiMonth = PaiMonth(year: year, symbol: $0.element, month: month)
                    return paiMonth
                })
                monthsInYears.append(contentsOf: months)
            }
        }
        return monthsInYears
    }
}
