//
//  DayCollectionView.swift
//  Pai
//
//  Created by Luqman Fauzi on 27/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import Foundation

internal typealias DailyEventsItem = (date: Date, event: PaiDateEvent?)

public class DayCollectionView: UICollectionView {

    // MARK: - Public Properties

    private var month: PaiMonth? {
        didSet {
            guard let month = month else { return }
            dates = PaiCalendar.current.datesCountInMonth(inMonth: month)
        }
    }

    // MARK: - Private Properties

    private var dailyEventsItems: [DailyEventsItem] = [] {
        didSet {
            reloadData()
        }
    }

    private var dates: [PaiDate] = [] {
        didSet {
            reloadData()
        }
    }

    public init() {
        let layout = DayFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        register(cellWithClass: DayViewCell.self)
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /// Configure `PaiMonth` & its `[PaiDateEvent]` events for particular month
    ///
    /// - Parameters:
    ///   - month: `PaiMonth`
    ///   - events: events in particular `PaiMonth`
    public func configure(_ month: PaiMonth, _ events: PaiMonthEvent?) {
        self.month = month
        /// initiate dailyEventsItems
        dailyEventsItems = dates.map({
            let items: DailyEventsItem = ($0.date, nil)
            return items
        })

        guard let events = events else { return }

        let allDateStr = Set(events.monthEvents.map({$0.dateStr}).sorted())
        allDateStr.forEach { (dateStr) in
            let dayEvent = events.monthEvents.first(where: {$0.dateStr == dateStr})
            if let index = dailyEventsItems.index(where: {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy M dd"
                return formatter.string(from: $0.date) == dateStr
            }) {
                dailyEventsItems[index] = (dates[index].date, dayEvent)
            }
        }
        reloadData()
    }
}

extension DayCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDataSource

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withClass: DayViewCell.self, for: indexPath),
            let monthItem = month
            else {
                fatalError("DayViewCell not found.")
        }

        let dateItem = dates[indexPath.item]
        cell.configure(date: dateItem.date)

        /// Configure date item cell by the 3 defined `DateItemStyle` values
        if let beginning = PaiCalendar.current.indexStartDate(inMonth: monthItem), indexPath.item < beginning {
            cell.configure(style: .offsetDate)
        } else if let end = PaiCalendar.current.indexEndDate(inMonth: monthItem), indexPath.item > end {
            cell.configure(style: .offsetDate)
        } else {
            if dateItem.isPastDate {
                cell.configure(style: .pastDate)
            } else if dateItem.isToday {
                cell.configure(style: .today)
            } else {
                cell.configure(style: .insetDate)
            }
        }

        /// Configure events for particular date
        let eventItem = dailyEventsItems[indexPath.item]
        cell.configureEvent(item: eventItem)

        return cell
    }

    // MARK: - UICollectionViewDelegate

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dates[indexPath.item]
        let index = indexPath.item
        let object: (PaiDate, Int) = (item, index)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "me.luqmanfauzi.Pai"), object: object)
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: CGFloat = collectionView.bounds.width / CGFloat(7)
        let itemHeight: CGFloat = itemWidth
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

