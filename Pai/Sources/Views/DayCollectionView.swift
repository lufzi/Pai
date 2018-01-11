//
//  DayCollectionView.swift
//  Pai
//
//  Created by Luqman Fauzi on 27/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import Foundation

public class DayCollectionView: UICollectionView {

    // MARK: - Public Properties

    private var month: PaiMonth? {
        didSet {
            guard let month = month else { return }
            dates = PaiCalendar.current.datesCountInMonth(inMonth: month)
        }
    }

    // MARK: - Private Properties

    private var dates: [PaiDate] = [] {
        didSet {
            reloadData()
        }
    }

    private var thisMonthEvents: [PaiDateEvent] = [] {
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

    /// Setup data for `DayCollectionView`.
    ///
    /// - Parameter month: `PaiMonth`
    public func setup(_ month: PaiMonth) {
        self.month = month
    }

    /// Populates all the events for a particular month & year.
    ///
    /// - Parameter events: `[PaiDateEvent]?`
    public func populateCalendarEventsWithinMonth(_ events: [PaiDateEvent]?) {
        guard let monthItem = month, let events = events else {
            return
        }

        let currentMonthNumber: String = (monthItem.month.rawValue + 1).description
        let currentYear: String = monthItem.year.description

        /// Get all events in this particular month & year.
        thisMonthEvents = events.filter({ event in
            /// Filter event of the year.
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            let yearString: String = formatter.string(from: event.date)
            return (currentYear == yearString)
        }).filter({ event in
            /// Filter event of the month.
            let formatter = DateFormatter()
            formatter.dateFormat = "M"
            let monthNumber: String = formatter.string(from: event.date)
            return (currentMonthNumber == monthNumber)
        })
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

        let item = dates[indexPath.item]
        cell.configure(date: item.date)

        /// Filter event of the particular date, according to collectionView item index.
        let theDayEvents = thisMonthEvents.filter({
            Calendar.autoupdatingCurrent.compare($0.date, to: item.date, toGranularity: .day) == .orderedSame
        })
        cell.configure(events: theDayEvents)

        /// Configure date item cell by the 3 defined `DateItemStyle` values
        if let beginning = PaiCalendar.current.indexStartDate(inMonth: monthItem), indexPath.item < beginning {
            cell.configure(style: .offsetDate)
        } else if let end = PaiCalendar.current.indexEndDate(inMonth: monthItem), indexPath.item > end {
            cell.configure(style: .offsetDate)
        } else {
            if item.isPastDate {
                cell.configure(style: .pastDate)
            } else if item.isToday {
                cell.configure(style: .today)
            } else {
                cell.configure(style: .insetDate)
            }
        }
        return cell
    }

    // MARK: - UICollectionViewDelegate

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dates[indexPath.item + 1]
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
