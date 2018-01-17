//
//  ExampleViewController.swift
//  Pai-Example
//
//  Created by Luqman Fauzi on 21/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit
import Pai

final class ExampleViewController: UIViewController, PaiCalendarDelegate, PaiCalendarDataSource {

    private var style: PaiStyle = {
        let style = PaiStyle.shared
        style.dateItemShouldGreyOutPastDates = true
        style.dateItemShouldHideOffsetDates = true
        style.dateItemShouldDisplayLine = true
        /// Date events configuration
        style.dateItemDayLabelInset = UIEdgeInsets(top: 3.0, left: 8.0, bottom: 30.0, right: 8.0)
        style.dateItemDisplayEventsIfAny = true
        return style
    }()

    private lazy var monthlyView: MonthCollectionView = {
        let view = MonthCollectionView(style: self.style, backwardsMonths: 24, forwardsMonths: 24, calendarDataSource: self)
        view.calendarDelegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Today", style: .done, target: self, action: #selector(didTapToday))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(monthlyView)

        NSLayoutConstraint.activate([
            monthlyView.topAnchor.constraint(equalTo: view.topAnchor),
            monthlyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            monthlyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            monthlyView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    @objc func didTapToday() {
        monthlyView.scrolltoCurrentMonth()
    }

    // MARK: - PaiCalendarDelegate

    func calendarDateDidSelect(in calendar: MonthCollectionView, at index: Int, date: PaiDate) {
        print("Selected date: \(date.date)")
    }

    func calendarMonthViewDidScroll(in calendar: MonthCollectionView, at index: Int, month: String, year: String) {
        title = month + " " + year
    }

    // MARK: - PaiCalendarDataSourc

    func calendarDateEvents(in calendar: MonthCollectionView) -> [PaiDateEvent] {
        let events = PaiDateEvent.generateRandom(numberOfEvents: 6)
        return events
    }
}
