//
//  PromoCodesViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 15.01.2022.
//

import UIKit
import SnapKit

final class PromoCodesViewController: BaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

// MARK: - TabBarItem

extension PromoCodesViewController: TabBarItem {
    
    var tabBarTitle: String? {
        L10n.PromoCodes.promoCodes
    }
    
    var tabBarImage: UIImage {
        Asset.iconPromoCodes.image
    }
}
