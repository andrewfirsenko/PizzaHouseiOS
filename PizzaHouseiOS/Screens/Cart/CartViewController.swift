//
//  CartViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 15.01.2022.
//

import UIKit
import SnapKit

final class CartViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

// MARK: - TabBarItem

extension CartViewController: TabBarItem {
    
    var tabBarTitle: String? {
        L10n.Cart.cart
    }
    
    var tabBarImage: UIImage {
        Asset.iconCart.image
    }
}
