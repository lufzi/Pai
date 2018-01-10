//
//  DayViewCell.swift
//  Pai
//
//  Created by Luqman Fauzi on 22/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

internal class DayViewCell: UICollectionViewCell {

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = PaiStyle.shared.dateItemFont
        label.textAlignment = .center
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        return label
    }()

    private lazy var indicator: CALayer = {
        let layer = CALayer()
        return layer
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = PaiStyle.shared.dateItemBackgroundColor
        indicator.frame = UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        indicator.cornerRadius = indicator.frame.height * 0.5
        layer.sublayers?.append(indicator)
        dateLabel.frame = UIEdgeInsetsInsetRect(bounds, .zero)
        addSubview(dateLabel)
    }

    public func configure(date: Date, style: DateItemStyle) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        dateLabel.text = formatter.string(from: date)

        switch style {
        case .pastDate:
            let isShouldGrayOut = PaiStyle.shared.dateItemShouldGreyOutPastDates
            let activeColor = PaiStyle.shared.dateItemNormalTextColor
            dateLabel.textColor = isShouldGrayOut ? .lightGray : activeColor
            indicator.backgroundColor = UIColor.clear.cgColor
        case .today:
            dateLabel.textColor = PaiStyle.shared.dateItemTodayIndicatorTextColor
            indicator.backgroundColor = PaiStyle.shared.dateItemTodayIndicatorColor.cgColor
        case .active:
            dateLabel.textColor = PaiStyle.shared.dateItemNormalTextColor
            indicator.backgroundColor = UIColor.clear.cgColor
        case .offsetDate:
            let isShouldBeHidden = PaiStyle.shared.dateItemShouldHideOffsetDates
            let excludedColor = PaiStyle.shared.dateItemExcludedTextColor
            dateLabel.textColor = isShouldBeHidden ? .clear : excludedColor
            indicator.backgroundColor = UIColor.clear.cgColor
        }
    }
}
