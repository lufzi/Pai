//
//  DayViewCell.swift
//  Pai
//
//  Created by Luqman Fauzi on 22/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

final class DayViewCell: UICollectionViewCell {

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = PaiStyle.shared.dateItemFont
        label.textAlignment = .center
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        return label
    }()

    private lazy var todayIndicator: CALayer = {
        let layer = CALayer()
        return layer
    }()

    private lazy var topLine: CALayer = {
        let layer = CALayer()
        return layer
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = PaiStyle.shared.dateItemBackgroundColor

        topLine.frame = CGRect(x: 0, y: 0.7, width: bounds.width, height: 0.7)
        topLine.backgroundColor = UIColor.clear.cgColor
        layer.addSublayer(topLine)

        todayIndicator.frame = UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        todayIndicator.cornerRadius = todayIndicator.frame.height * 0.5
        layer.addSublayer(todayIndicator)

        dateLabel.frame = UIEdgeInsetsInsetRect(bounds, .zero)
        addSubview(dateLabel)
    }

    func configure(date: Date, style: DateItemStyle) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        dateLabel.text = formatter.string(from: date)
        
        let topLineColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        let isDisplayDateTopLine = PaiStyle.shared.dateItemShouldDisplayLine
        let isPastDateGrayOut = PaiStyle.shared.dateItemShouldGreyOutPastDates
        let isOffsetDateHidden = PaiStyle.shared.dateItemShouldHideOffsetDates
        let insetDateColor = PaiStyle.shared.dateItemNormalTextColor
        let offsetDateColor = PaiStyle.shared.dateItemExcludedTextColor

        switch style {
        case .pastDate:
            topLine.backgroundColor = isDisplayDateTopLine ? topLineColor : UIColor.clear.cgColor
            todayIndicator.backgroundColor = UIColor.clear.cgColor
            dateLabel.textColor = isPastDateGrayOut ? .lightGray : insetDateColor
        case .today:
            topLine.backgroundColor = isDisplayDateTopLine ? topLineColor : UIColor.clear.cgColor
            todayIndicator.backgroundColor = PaiStyle.shared.dateItemTodayIndicatorColor.cgColor
            dateLabel.textColor = PaiStyle.shared.dateItemTodayIndicatorTextColor
        case .insetDate:
            topLine.backgroundColor = isDisplayDateTopLine ? topLineColor : UIColor.clear.cgColor
            todayIndicator.backgroundColor = UIColor.clear.cgColor
            dateLabel.textColor = insetDateColor
        case .offsetDate:
            topLine.backgroundColor = UIColor.clear.cgColor
            todayIndicator.backgroundColor = UIColor.clear.cgColor
            dateLabel.textColor = isOffsetDateHidden ? .clear : offsetDateColor
        }
    }
}
