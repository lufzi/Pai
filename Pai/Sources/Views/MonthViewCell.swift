//
//  MonthViewCell.swift
//  Pai
//
//  Created by Luqman Fauzi on 26/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

final class MonthViewCell: UICollectionViewCell {

    private lazy var dayCollectionView: DayCollectionView = {
        let collectionView = DayCollectionView()
        return collectionView
    }()

    private var calendar = PaiCalendar.current
    private var weeksOfMonthCount: Int {
        return calendar.veryShortWeekdaySymbols.count
    }

    private lazy var weekdaySymbolLabels: [UILabel] = {
        var labels: [UILabel] = []
        for symbol in calendar.veryShortWeekdaySymbols {
            let label = UILabel()
            label.font = PaiStyle.shared.dateItemSymbolFont
            label.textColor = PaiStyle.shared.dateItemSymbolTextColor
            label.backgroundColor = PaiStyle.shared.dateItemBackgroundColor
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.isUserInteractionEnabled = true
            label.text = symbol
            labels.append(label)
        }
        return labels
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        let weekdaySymbolHeight: CGFloat = 25.0
        let weekdaySymbolWidth: CGFloat = bounds.width / CGFloat(weekdaySymbolLabels.count)
        weekdaySymbolLabels.enumerated().forEach { (index, label) in
            let originX: CGFloat = weekdaySymbolWidth * CGFloat(index)
            label.frame = CGRect(x: originX, y: 0, width: weekdaySymbolWidth, height: weekdaySymbolHeight)
            label.backgroundColor = .white
            addSubview(label)
        }

        dayCollectionView.frame = UIEdgeInsetsInsetRect(
            bounds,
            UIEdgeInsets(top: weekdaySymbolHeight, left: 0, bottom: 0, right: 0)
        )
        addSubview(dayCollectionView)
    }

    func configure(monthIndex: Int) {
        dayCollectionView.month = Month(rawValue: monthIndex) ?? .jan
    }
}
