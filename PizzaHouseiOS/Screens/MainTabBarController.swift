//
//  MainTabBarController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 15.01.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        configureAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        UserDefaults.standard.wasOnboarding = true
    }
    
    
    // MARK: - Private
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        // Stop double tap MainVC
//        let indexOfNewVC = tabBarController.viewControllers?.firstIndex(of: viewController)
//        return ((indexOfNewVC != 0) || (indexOfNewVC != tabBarController.selectedIndex))
//    }
    
    private func setupTabs() {
        let controllers: [TabBarItem] = [
            MenuViewController(),
            ProfileViewController(),
            PromoCodesViewController(),
            CartViewController()
        ]
        
        for i in controllers {
            i.tabBarItem = UITabBarItem(
                title: i.tabBarTitle ?? "",
                image: i.tabBarImage,
                selectedImage: i.tabBarSelectedImage ?? i.tabBarImage
            )
        }
        let navControlles = controllers.map { controller -> UINavigationController in
            let navC = UINavigationController(rootViewController: controller)
            navC.isNavigationBarHidden = true
            return navC
        }
        
        viewControllers = navControlles
    }
    
    private func configureAppearance() {
        view.backgroundColor = .white
        tabBar.tintColor = Asset.orange.color
        tabBar.barTintColor = Asset.gray.color
        // Remove default line
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = Asset.mainBackground.color
        // Add only shadow
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 4.0
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.layer.shadowOpacity = 0.2
    }
}
