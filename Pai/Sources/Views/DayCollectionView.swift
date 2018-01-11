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

    public func setup(_ month: PaiMonth) {
        self.month = month
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

        /// Configure date item cell by the 3 defined `DateItemStyle` values
        if let beginning = PaiCalendar.current.indexStartDate(inMonth: monthItem), indexPath.item < beginning {
            cell.configure(date: item.date, style: .offsetDate)
        } else if let end = PaiCalendar.current.indexEndDate(inMonth: monthItem), indexPath.item > end {
            cell.configure(date: item.date, style: .offsetDate)
        } else {
            if item.isPastDate {
                cell.configure(date: item.date, style: .pastDate)
            } else if item.isToday {
                cell.configure(date: item.date, style: .today)
            } else {
                cell.configure(date: item.date, style: .insetDate)
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
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
