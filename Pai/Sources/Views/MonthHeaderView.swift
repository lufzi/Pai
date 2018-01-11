//
//  MonthHeaderView.swift
//  Pai
//
//  Created by Luqman Fauzi on 26/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

final class MonthHeaderView: UICollectionReusableView {

    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.font = PaiStyle.shared.monthItemHeaderFont
        label.textAlignment = PaiStyle.shared.monthItemHeaderTextAlignment
        label.textColor = PaiStyle.shared.monthItemHeaderTextColor
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = PaiStyle.shared.monthItemHeaderBackgroundColor
        symbolLabel.frame = UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 15.0))
        addSubview(symbolLabel)
    }

    public func configure(monthSymbol: String, yearSymbol: String) {
        symbolLabel.text = monthSymbol + " " + yearSymbol
    }
}
