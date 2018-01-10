//
//  MonthCollectionView.swift
//  Pai
//
//  Created by Luqman Fauzi on 22/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

open class MonthCollectionView: UICollectionView {

    let calendar = PaiCalendar.current
    var style: PaiStyle

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
    }

    required public init?(coder aDecoder: NSCoder) {
        style = PaiStyle.shared
        super.init(coder: aDecoder)
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
