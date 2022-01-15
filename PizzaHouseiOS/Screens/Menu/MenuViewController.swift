//
//  MenuViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 15.01.2022.
//

import UIKit
import SnapKit

final class MenuViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

// MARK: - TabBarItem

extension MenuViewController: TabBarItem {
    
    var tabBarTitle: String? {
        L10n.Menu.menu
    }
    
    var tabBarImage: UIImage {
        Asset.iconPizza.image
    }
}
