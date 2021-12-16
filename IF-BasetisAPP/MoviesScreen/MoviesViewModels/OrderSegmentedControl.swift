//
//  OrderSegmentedControl.swift
//  IF-BasetisAPP
//
//  Created by Ivet Acosta on 29/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit

class OrderSegmentedControlView: UICollectionReusableView {
    
    enum OrderStatus {
        case alphabetic
        case random
        var index: Int {
            switch self {
            case .alphabetic:
                return 0
            case .random:
                return 1
            }
        }
        var text: String {
            switch self {
            case .alphabetic:
                return "Alphabetic order"
            case .random:
                return "Random order"
            }
        }
    }
    
    var collectionViewModel = MoviesViewModel()
    var collectionView: UICollectionView?
    var orderSegmentedControl = UISegmentedControl()
    
    func setUpSegmentedControl() {
        orderSegmentedControl = UISegmentedControl.init(items: [OrderStatus.alphabetic.text, OrderStatus.random.text])
        updateSegmentedControlWidth()
        orderSegmentedControl.selectedSegmentIndex = OrderStatus.alphabetic.index
        orderSegmentedControl.addTarget(self, action: #selector(segmentedControlAction(_:)), for: .valueChanged)
        self.addSubview(orderSegmentedControl)
    }
    
    func updateSegmentedControlWidth() {
        orderSegmentedControl.frame = CGRect(x: 15, y: 0, width: UIScreen.main.bounds.width - 30, height: 35)
    }
    
    @objc func segmentedControlAction(_ segmentedControl: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == OrderStatus.alphabetic.index {
            self.collectionViewModel.sortMoviesAlphabetically()
        } else {
            self.collectionViewModel.sortMoviesRandomly()
        }
        collectionView?.reloadData()
    }
    
}
