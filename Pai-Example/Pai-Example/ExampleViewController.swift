//
//  ExampleViewController.swift
//  Pai-Example
//
//  Created by Luqman Fauzi on 21/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit
import Pai

final class ExampleViewController: UIViewController, PaiCalendarDelegate {

    private var style: PaiStyle = {
        let style = PaiStyle.shared
        style.dateItemShouldGreyOutPastDates = true
        style.dateItemShouldHideOffsetDates = true
        return style
    }()

    private lazy var monthlyView: MonthCollectionView = {
        let view = MonthCollectionView(style: self.style)
        view.calendarDelegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
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

    // MARK: - PaiCalendarDelegate

    func calendarDateDidSelect(in calendar: MonthCollectionView, at index: Int, date: PaiDate) {
        print("Selected date: \(date.date)")
    }
}
