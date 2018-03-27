//
//  DayViewCell.swift
//  Pai
//
//  Created by Luqman Fauzi on 22/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

final class DayViewCell: UICollectionViewCell {

    // MARK: - Private Properties

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

    private lazy var dotsIndicator: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.bounds.width - 15.0, height: 20.0)
        for i in 0...2 {
            let accumulator = CGFloat(i) * 3.5
            let x = (view.bounds.width * 0.5) - 3.5 + accumulator
            let frame = CGRect(x: x, y: 1.0, width: 1.5, height: 1.5)
            let dotPath = UIBezierPath(ovalIn: frame)
            let layer = CAShapeLayer()
            layer.path = dotPath.cgPath
            layer.strokeColor = UIColor.lightGray.cgColor
            view.layer.addSublayer(layer)
        }
        return view
    }()

    private lazy var eventsStackView: UIStackView = {
        let view = UIStackView()
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

    public func configureEvent(item: DailyEventsItem) {
        guard PaiStyle.shared.dateItemDisplayEventsIfAny, let event = item.event else {
            eventsStackView.isHidden = true
            return
        }
        eventsStackView.isHidden = false
        dotsIndicator.removeFromSuperview()
        let eventView = getEventView(event: event)
        eventsStackView.arrangedSubviews.forEach({eventsStackView.removeArrangedSubview($0)})
        eventView.forEach({eventsStackView.addArrangedSubview($0)})
    }

    private func getEventView(event: PaiDateEvent) -> [UIView] {
        let maxStacks = 6
        let stacks = event.tagColors.count
        var views: [UIView] = []
        for (index,color) in event.tagColors.enumerated() {
            let view: UIView
            if (index + 1) == maxStacks {
                view = dotsIndicator
                view.translatesAutoresizingMaskIntoConstraints = false
                view.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
                views.append(view)
                return views
            } else {
                view = UIView()
                view.backgroundColor = color
                view.translatesAutoresizingMaskIntoConstraints = false
                view.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
                views.append(view)
            }
        }
        return views
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

