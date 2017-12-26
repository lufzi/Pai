//
//  DailyViewCell.swift
//  Pai
//
//  Created by Luqman Fauzi on 22/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

internal class DailyViewCell: UICollectionViewCell {

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.cyan
        dateLabel.frame = UIEdgeInsetsInsetRect(bounds, .zero)
        addSubview(dateLabel)
    }

    public func configure(dateSymbol: String) {
        dateLabel.text = dateSymbol
    }
}
