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
        label.isUserInteractionEnabled = true
        label.font = PaiStyle.shared.dateItemFont
        label.textAlignment = .center
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = PaiStyle.shared.dateItemBackgroundColor
        dateLabel.frame = UIEdgeInsetsInsetRect(bounds, .zero)
        addSubview(dateLabel)
    }

    public func configure(date: Date, style: DateItemStyle) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        dateLabel.text = formatter.string(from: date)
        switch style {
        case .normal:
            dateLabel.textColor = PaiStyle.shared.dateItemNormalTextColor
        case .excluded:
            let isShouldBeHidden = PaiStyle.shared.dateItemShouldHideExcludedDate
            let excludedColor = PaiStyle.shared.dateItemExcludedTextColor
            dateLabel.textColor = isShouldBeHidden ? .clear : excludedColor
        }
    }
}
