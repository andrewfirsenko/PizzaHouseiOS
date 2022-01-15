//
//  TabBarItem.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 15.01.2022.
//

import Foundation
import UIKit

protocol TabBarItem: UIViewController {
    var tabBarTitle: String? { get }
    var tabBarImage: UIImage { get }
    var tabBarSelectedImage: UIImage? { get }
}

extension TabBarItem {
    
    var tabBarTitle: String? {
        nil
    }
    
    var tabBarSelectedImage: UIImage? {
        nil
    }
}
