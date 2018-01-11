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

    private lazy var eventViews: [UIView] = {
        let maxStacks = 6
        var views: [UIView] = []
        for i in 1...maxStacks {
            let view = UIView()
            view.backgroundColor = (i == maxStacks) ? .yellow : .clear
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
            views.append(view)
        }
        return views
    }()

    private lazy var eventsStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: self.eventViews)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.isBaselineRelativeArrangement = true
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = 1.0
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.backgroundColor = PaiStyle.shared.dateItemBackgroundColor

        topLine.frame = CGRect(x: 0, y: 0.7, width: bounds.width, height: 0.7)
        topLine.backgroundColor = UIColor.clear.cgColor
        layer.addSublayer(topLine)

        let labelFrame = UIEdgeInsetsInsetRect(bounds, PaiStyle.shared.dateItemDayLabelInset)
        todayIndicator.frame = labelFrame
        todayIndicator.cornerRadius = todayIndicator.frame.height * 0.5
        layer.addSublayer(todayIndicator)

        dateLabel.frame = labelFrame
        addSubview(dateLabel)

        if PaiStyle.shared.dateItemDisplayEventsIfAny {
            addSubview(eventsStackView)
            NSLayoutConstraint.activate([
                eventsStackView.topAnchor.constraint(equalTo: topAnchor, constant: labelFrame.height + 5.0),
                eventsStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
                eventsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
                eventsStackView.widthAnchor.constraint(equalToConstant: bounds.width - 15.0)
            ])
        }
    }

    public func configure(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        dateLabel.text = formatter.string(from: date)
    }

    public func configure(events: [PaiDateEvent]) {
        guard PaiStyle.shared.dateItemDisplayEventsIfAny, !(events.isEmpty) else {
            eventsStackView.isHidden = true
            return
        }
        if events.count <= 5 {
            /// Remove last subview in stackview.
            eventsStackView.removeArrangedSubview(eventsStackView.arrangedSubviews.last!)
            eventViews.last?.removeFromSuperview()
        }
        for (index, event) in events.enumerated() {
            if 0...4 ~= index {
                /// Within 5 events range
                eventsStackView.arrangedSubviews[index].backgroundColor = event.tagColor
            } else {
                break
            }
        }
    }

    public func configure(style: DateItemStyle) {
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
