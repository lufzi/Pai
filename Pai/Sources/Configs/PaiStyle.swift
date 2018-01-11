//
//  PaiStyle.swift
//  Pai
//
//  Created by Luqman Fauzi on 10/01/2018.
//  Copyright © 2018 Luqman Fauzi. All rights reserved.
//

import Foundation

public enum DateItemStyle {
    case today, insetDate, offsetDate, pastDate
}

public class PaiStyle {

    private init() { }
    public static let shared = PaiStyle()

    public var dateItemFont: UIFont = UIFont.systemFont(ofSize: 17.0, weight: .medium)
    public var dateItemNormalTextColor: UIColor = .darkGray
    public var dateItemExcludedTextColor: UIColor = .lightGray
    public var dateItemBackgroundColor: UIColor = .white
    public var dateItemTodayIndicatorColor: UIColor = .red
    public var dateItemTodayIndicatorTextColor: UIColor = .white
    public var dateItemShouldHideOffsetDates: Bool = false
    public var dateItemShouldGreyOutPastDates: Bool = false
    public var dateItemShouldDisplayLine: Bool = false

    public var dateItemSymbolFont: UIFont = UIFont.systemFont(ofSize: 17.0, weight: .bold)
    public var dateItemSymbolTextColor: UIColor = .black
    public var dateItemSymbolBackgroundColor: UIColor = .white
    public var dateItemDayLabelInset: UIEdgeInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)

    public var monthItemHeaderFont: UIFont = UIFont.systemFont(ofSize: 20.0, weight: .heavy)
    public var monthItemHeaderTextAlignment: NSTextAlignment = .left
    public var monthItemHeaderBackgroundColor: UIColor = .white
    public var monthItemHeaderTextColor: UIColor = .red
    public var monthItemHeaderShouldPin: Bool = false
    public var monthItemHeaderHeight: CGFloat = 50.0
    public var monthItemPadding: CGFloat = 0

    public var dateItemDisplayEventsIfAny: Bool = false
}
