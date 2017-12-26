//
//  MonthlyViewCell.swift
//  Pai
//
//  Created by Luqman Fauzi on 26/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

internal class MonthlyViewCell: UICollectionViewCell {

    private lazy var dailyCollectionView: DailyCollectionView = {
        let collectionView = DailyCollectionView()
        return collectionView
    }()

    private var calendar = PaiCalendar.current
    private var weeksOfMonthCount: Int {
        return calendar.weeksOfMonths
    }

    private lazy var weekdaySymbolLabels: [UILabel] = {
        var labels: [UILabel] = []
        for symbol in calendar.veryShortWeekdaySymbols {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.isUserInteractionEnabled = true
            label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
            label.textAlignment = .center
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

        dailyCollectionView.frame = UIEdgeInsetsInsetRect(
            bounds,
            UIEdgeInsets(top: weekdaySymbolHeight, left: 0, bottom: 0, right: 0)
        )
        addSubview(dailyCollectionView)
    }
}
