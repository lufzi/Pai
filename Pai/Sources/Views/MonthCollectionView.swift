//
//  MonthCollectionView.swift
//  Pai
//
//  Created by Luqman Fauzi on 22/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

public class MonthCollectionView: UICollectionView {

    private let calendar = PaiCalendar.current
    public var style: PaiStyle
    public weak var calendarDelegate: PaiCalendarDelegate?

    public init(style: PaiStyle) {
        self.style = style
        let layout = MonthVerticalFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        register(cellWithClass: MonthViewCell.self)
        register(supplementaryViewOfKind: UICollectionElementKindSectionHeader, withClass: MonthHeaderView.self)
        backgroundColor = UIColor.groupTableViewBackground
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
        showsVerticalScrollIndicator = false
        NotificationCenter.default.addObserver(self, selector: #selector(dateDidSelect), name: NSNotification.Name(rawValue: "me.luqmanfauzi.Pai"), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    required public init?(coder aDecoder: NSCoder) {
        style = PaiStyle.shared
        super.init(coder: aDecoder)
    }

    @objc private func dateDidSelect(_ notification: Notification) {
        guard let object = notification.object as? (PaiDate, Int) else {
            return
        }
        let date = object.0
        let index = object.1
        calendarDelegate?.calendarDateDidSelect(in: self, at: index, date: date)
    }
}

extension MonthCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDataSource

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return calendar.monthsOfYearCount
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withClass: MonthViewCell.self, for: indexPath) else {
            fatalError("DayViewCell not found.")
        }
        cell.configure(monthIndex: indexPath.section)
        return cell
    }

    // MARK: - UICollectionViewDelegate

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item: \(indexPath.item)")
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
        let monthSymbol = calendar.shortMonthSymbols[indexPath.section]
        headerView.configure(monthSymbol: monthSymbol, yearSymbol: calendar.currentYear.description)
        return headerView
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        guard let month = Month(rawValue: indexPath.section) else {
            return CGSize(width: width, height: 0)
        }

        let itemsCountInSection = calendar.numberOfCells(inMonth: month)
        let itemsCountInRow = itemsCountInSection / 7
        let dateItemHeight: CGFloat = width / 7
        let symbolsHeight: CGFloat = 25.0
        let monthHeight: CGFloat = CGFloat(itemsCountInRow) * dateItemHeight + symbolsHeight
        return CGSize(width: width, height: monthHeight)
    }
}
