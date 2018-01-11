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
    static func generatesInYears(from startYear: Int, to endYear: Int) -> [PaiMonth] {
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
}
