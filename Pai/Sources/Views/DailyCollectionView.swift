//
//  DailyCollectionView.swift
//  Pai
//
//  Created by Luqman Fauzi on 27/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import Foundation

internal class DailyCollectionView: UICollectionView {

    let calendar = PaiCalendar.current

    var dateSymbols: [String] {
        var dates: [Int] = []
        for number in 1...30 {
            dates.append(number)
        }
        return dates.map({ $0.description })
    }

    public init() {
        let layout = DailyViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        register(cellWithClass: DailyViewCell.self)
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension DailyCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDataSource

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateSymbols.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withClass: DailyViewCell.self, for: indexPath) else {
            fatalError("DayViewCell not found.")
        }
        let daySymbol = dateSymbols[indexPath.item]
        cell.configure(dateSymbol: daySymbol)
        return cell
    }

    // MARK: - UICollectionViewDelegate

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected day: \(indexPath.item)")
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: CGFloat = collectionView.bounds.width / CGFloat(calendar.weekdaySymbols.count)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
