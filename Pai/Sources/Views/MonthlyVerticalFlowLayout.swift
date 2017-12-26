//
//  MonthlyVerticalFlowLayout.swift
//  Pai
//
//  Created by Luqman Fauzi on 26/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import Foundation

internal class MonthlyVerticalFlowLayout: UICollectionViewFlowLayout {

    private var calendar = PaiCalendar.current

    override init() {
        super.init()
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0

        let width: CGFloat = UIScreen.main.bounds.width
        headerReferenceSize = CGSize(width: width, height: 40.0)

        let weekdaySymbolHeight: CGFloat = 25.0
        let dateItemHeight: CGFloat = width / CGFloat(calendar.weekdaySymbols.count)
        let monthItemHeight: CGFloat = weekdaySymbolHeight + (dateItemHeight * 5)
        itemSize = CGSize(width: width, height: monthItemHeight)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
