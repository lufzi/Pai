//
//  PaiDate.swift
//  Pai
//
//  Created by Luqman Fauzi on 11/01/2018.
//  Copyright © 2018 Luqman Fauzi. All rights reserved.
//

import Foundation

public struct PaiDate {

    public let date: Date

    public var isPastDate: Bool {
        return Calendar.autoupdatingCurrent.compare(date, to: Date(), toGranularity: .day) == .orderedAscending
    }

    public var isToday: Bool {
        return Calendar.autoupdatingCurrent.compare(date, to: Date(), toGranularity: .day) == .orderedSame
    }
}
