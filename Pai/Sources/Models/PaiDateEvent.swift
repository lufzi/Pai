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

    public let name: String?

    public let tagColor: UIColor

    /// Initlizer of the struct
    ///
    /// - Parameters:
    ///   - date: `Date` of event
    ///   - name: optional `String` of event name
    ///   - tagColor: `UIColor` tag color of event
    public static func initObject(date: Date, name: String?, tagColor: UIColor) -> PaiDateEvent {
        return PaiDateEvent(date: date, name: name, tagColor: tagColor)
    }
}

public extension PaiDateEvent {
    public static func generateRandom(numberOfEvents: Int) -> [PaiDateEvent] {
        var events: [PaiDateEvent] = []
        for i in 1...numberOfEvents {
            let color: UIColor = (i % 2 == 0) ? .red : .blue
            let event = PaiDateEvent(date: Date(), name: nil, tagColor: color)
            events.append(event)
        }
        return events
    }
}
