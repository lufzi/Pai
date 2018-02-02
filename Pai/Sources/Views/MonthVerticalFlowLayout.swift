//
//  MonthVerticalFlowLayout.swift
//  Pai
//
//  Created by Luqman Fauzi on 26/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import Foundation

final class MonthVerticalFlowLayout: UICollectionViewFlowLayout {

    private var calendar = PaiCalendar.current

    override init() {
        super.init()
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        sectionHeadersPinToVisibleBounds = PaiStyle.shared.monthItemHeaderShouldPin

        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: PaiStyle.shared.monthItemPadding, right: 0)

        let width: CGFloat = UIScreen.main.bounds.width
        headerReferenceSize = CGSize(width: width, height: PaiStyle.shared.monthItemHeaderHeight)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
