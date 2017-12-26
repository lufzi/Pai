//
//  ExampleViewController.swift
//  Pai-Example
//
//  Created by Luqman Fauzi on 21/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit
import Pai

final class ExampleViewController: UIViewController {

    private lazy var monthlyView: MonthlyCollectionView = {
        let view = MonthlyCollectionView()
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
}
