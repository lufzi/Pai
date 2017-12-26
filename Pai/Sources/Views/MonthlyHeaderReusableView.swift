//
//  MonthlyHeaderReusableView.swift
//  Pai
//
//  Created by Luqman Fauzi on 26/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

internal class MonthlyHeaderReusableView: UICollectionReusableView {

    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .heavy)
        label.textAlignment = .center
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        symbolLabel.frame = bounds
        addSubview(symbolLabel)
    }

    public func configure(monthSymbol: String) {
        symbolLabel.text = monthSymbol
    }
}
