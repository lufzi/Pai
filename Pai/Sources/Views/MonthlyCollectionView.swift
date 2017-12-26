//
//  MonthlyCollectionView.swift
//  Pai
//
//  Created by Luqman Fauzi on 22/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

open class MonthlyCollectionView: UICollectionView {

    let calendar = PaiCalendar.current

    var dateSymbols: [String] {
        var dates: [Int] = []
        for _ in 1...12 {
            for date in 1...30 {
                dates.append(date)
            }
        }
        return dates.map({ $0.description })
    }

    public init() {
        let layout = MonthlyVerticalFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        register(cellWithClass: MonthlyViewCell.self)
        register(supplementaryViewOfKind: UICollectionElementKindSectionHeader, withClass: MonthlyHeaderReusableView.self)
        backgroundColor = UIColor.lightGray
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension MonthlyCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDataSource

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return calendar.monthsOfYearCount
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withClass: MonthlyViewCell.self, for: indexPath) else {
            fatalError("DayViewCell not found.")
        }
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
            withClass: MonthlyHeaderReusableView.self,
            for: indexPath)
        else {
            fatalError("MonthlyHeaderReusableView not found.")
        }
        let symbol = calendar.monthSymbols[indexPath.section]
        headerView.configure(monthSymbol: symbol)
        return headerView
    }
}
