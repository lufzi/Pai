//
//  PaiDateEvent.swift
//  Pai
//
//  Created by Luqman Fauzi on 12/01/2018.
//  Copyright © 2018 Luqman Fauzi. All rights reserved.
//

import Foundation

public struct PaiDateEvent {

    public let date: Date

    public let tagColors: [UIColor]

    public var monthYearStr: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy M"
        return formatter.string(from: date)
    }

    public var dateStr: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy M dd"
        return formatter.string(from: date)

    }

    /// Initlizer of the struct
    ///
    /// - Parameters:
    ///   - date: `Date` of event
    ///   - tagColors: `[UIColor]` array of tag color
    public static func initObject(date: Date, tagColors: [UIColor]) -> PaiDateEvent {
        return PaiDateEvent(date: date, tagColors: tagColors)
    }
}

