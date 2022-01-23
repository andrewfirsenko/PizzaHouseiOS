//
//  ProfileViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 15.01.2022.
//

import UIKit
import SnapKit

final class ProfileViewController: BaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

// MARK: - TabBarItem

extension ProfileViewController: TabBarItem {
    
    var tabBarTitle: String? {
        L10n.Profile.profile
    }
    
    var tabBarImage: UIImage {
        Asset.iconProfile.image
    }
}

