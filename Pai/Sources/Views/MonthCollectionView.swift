//
//  MonthCollectionView.swift
//  Pai
//
//  Created by Luqman Fauzi on 22/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

internal typealias MonthlyEventsItem = (month: PaiMonth, events: PaiMonthEvent?)

public class MonthCollectionView: UICollectionView {

    // MARK: - Public Properties

    public var sharedStyle: PaiStyle
    public weak var calendarDelegate: PaiCalendarDelegate?
    public weak var calendarDataSource: PaiCalendarDataSource?

    // MARK: - Private Properties

    private var months: [PaiMonth]!
    private var montlyEventsItems: [MonthlyEventsItem] = []
    private var mostTopMonth: PaiMonth?
    private var currentlyScrollToCurrentMonth = false
    private var currentMonthIndex: IndexPath!{
        didSet{
            currentlyScrollToCurrentMonth = true
        }
    }

    public init(style: PaiStyle, startYear: Int, endYear: Int, calendarDataSource: PaiCalendarDataSource? = nil) {
        sharedStyle = style
        months = PaiMonth.generatesInYears(from: startYear, to: endYear)
        super.init(frame: .zero, collectionViewLayout: MonthVerticalFlowLayout())
        sharedInit(calendarDataSource: calendarDataSource)
    }

    public init(style: PaiStyle, backwardsMonths: Int, forwardsMonths: Int, calendarDataSource: PaiCalendarDataSource? = nil) {
        sharedStyle = style
        months = PaiMonth.generatesInMonts(backwardsCount: backwardsMonths, forwardsCount: backwardsMonths)
        super.init(frame: .zero, collectionViewLayout: MonthVerticalFlowLayout())
        sharedInit(calendarDataSource: calendarDataSource)
    }

    private func sharedInit(calendarDataSource: PaiCalendarDataSource? = nil) {
        /// Setup UI
        register(cellWithClass: MonthViewCell.self)
        register(supplementaryViewOfKind: UICollectionElementKindSectionHeader, withClass: MonthHeaderView.self)
        backgroundColor = UIColor.groupTableViewBackground
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
        showsVerticalScrollIndicator = false
        NotificationCenter.default.addObserver(self, selector: #selector(dateDidSelect), name: NSNotification.Name(rawValue: "me.luqmanfauzi.Pai"), object: nil)

        /// Initialiaze date events
        montlyEventsItems = self.months.map({
            let monthlyEvent: MonthlyEventsItem = ($0, nil)
            return monthlyEvent
        })
        /// Setup date events
        if let events = calendarDataSource?.calendarDateEvents(in: self) {
            self.calendarDataSource = calendarDataSource
            mapEventsForParticularMonths(events: events)
        }

        /// Scroll to current date if needed
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.scrolltoCurrentMonth()
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        sharedStyle = PaiStyle.shared
        super.init(coder: aDecoder)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    public func reloadEvents() {
        if let events = calendarDataSource?.calendarDateEvents(in: self) {
            mapEventsForParticularMonths(events: events)
        }
    }

    // MARK: - Private Methods

    /// Notification center event from tapping day item cell.
    ///
    /// - Parameter notification: `Notification` event from NotificationCenter
    @objc private func dateDidSelect(_ notification: Notification) {
        guard let object = notification.object as? (PaiDate, Int) else {
            return
        }
        let date = object.0
        let index = object.1
        calendarDelegate?.calendarDateDidSelect(in: self, at: index, date: date)
    }

    /// Send visible months to outside library
    private func sendVisibleCell() {
        /// Send back array of current visible month after scrolling
        var visibleMonthsStr = [String]()
        for cell in visibleCells {
            if let indexPath = indexPath(for: cell) {
                let selectedMonth = months[indexPath.section]
                let selectedMonthStr = "\(selectedMonth.year)-\(selectedMonth.month.rawValue + 1)-15"
                visibleMonthsStr.append(selectedMonthStr)
            }
        }
        calendarDelegate?.calendarMonthVisibleMonth(in: self, datesString: visibleMonthsStr)
    }

    /// Map all events into particular months
    ///
    /// - Parameter events: All `[PaiMonthEvent]` events from outside library.
    private func mapEventsForParticularMonths(events: [PaiMonthEvent]) {
        events.forEach { (monthEvents) in
            if let index = montlyEventsItems.index(where: {"\($0.month.year) \($0.month.month.rawValue + 1)" == monthEvents.monthYearStr}) {
                montlyEventsItems[index] = (months[index] , monthEvents)
            }
        }
        reloadData()
    }

    /// Scroll to current month, which contains today.
    ///
    /// - Parameter animated: animation effect upon dragging.
    public func scrolltoCurrentMonth() {
        let components = Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day], from: Date())
        let currentMonth = components.month
        let currentYear = components.year
        guard
            let index = months.index(where: { $0.year == currentYear && $0.month.rawValue + 1 == currentMonth })
            else { return }

        let indexPath = IndexPath(item: 0, section: index)
        scrollToItem(at: indexPath, at: .top, animated: true)
        currentMonthIndex = indexPath
    }
}

extension MonthCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDataSource

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return months.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withClass: MonthViewCell.self, for: indexPath) else {
            fatalError("DayViewCell not found.")
        }
        let item = montlyEventsItems[indexPath.section]
        cell.configure(eventsItem: item)
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind:
            UICollectionElementKindSectionHeader,
                                                                               withClass: MonthHeaderView.self,
                                                                               for: indexPath)
            else {
                fatalError("MonthlyHeaderReusableView not found.")
        }
        let month = months[indexPath.section]
        headerView.configure(monthSymbol: month.symbol, year: month.year)
        return headerView
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let month = months[indexPath.section]
        let itemsCountInSection = PaiCalendar.current.numberOfItemMonthCells(inMonth: month)
        let itemsCountInRow = itemsCountInSection / 7
        let dateItemHeight: CGFloat = width / 7
        let symbolsHeight: CGFloat = 25.0
        let monthHeight: CGFloat = CGFloat(itemsCountInRow) * dateItemHeight + symbolsHeight
        return CGSize(width: width, height: monthHeight)
    }

    // MARK: - UIScrollView Delegate

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pointY = scrollView.contentOffset.y + PaiStyle.shared.monthItemHeaderHeight
        let point = CGPoint(x: 0, y: pointY)
        if let indexPath = indexPathForItem(at: point) {
            let selectedMonth = months[indexPath.section]
            if mostTopMonth == nil {
                mostTopMonth = selectedMonth
                calendarDelegate?.calendarMonthViewDidScroll(in: self, at: indexPath.section, month: selectedMonth.symbol, year: "\(selectedMonth.year)")
            } else {
                let aldyDisplayMonth = mostTopMonth?.month == selectedMonth.month && mostTopMonth?.year == selectedMonth.year
                if !aldyDisplayMonth {
                    mostTopMonth = selectedMonth
                    calendarDelegate?.calendarMonthViewDidScroll(in: self, at: indexPath.section, month: selectedMonth.symbol, year: "\(selectedMonth.year)")
                }
            }
        }
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            sendVisibleCell()
        }
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        sendVisibleCell()
    }

    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if currentlyScrollToCurrentMonth {
            currentlyScrollToCurrentMonth = false
            let offsetY = (PaiStyle.shared.monthItemHeaderHeight)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let cell = self.cellForItem(at: self.currentMonthIndex) {
                    self.setContentOffset(CGPoint(x: 0.0 , y: cell.frame.origin.y - offsetY), animated: false)
                }
            }
        }
    }
}

