//
//  MenuViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 15.01.2022.
//

import UIKit
import SnapKit
import Parchment

final class MenuViewController: UIViewController {
    
    // UI
    private lazy var pagingViewController: PagingViewController = {
        let v1 = UIViewController()
        v1.view.backgroundColor = .green
        let v2 = UIViewController()
        v2.view.backgroundColor = .gray
        let v3 = UIViewController()
        v3.view.backgroundColor = .brown
        return PagingViewController(viewControllers: [v1, v2, v3])
    }()
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        addViews()
        configureLayout()
        
        pagingViewController.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        configureLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    // MARK: - Private
    
    private func addViews() {
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
    }
    
    private func configureLayout() {
        pagingViewController.view.snp.removeConstraints()
        pagingViewController.view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(view.safeAreaInsets.top)
            $0.bottom.equalToSuperview().inset(view.safeAreaInsets.bottom)
        }
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


// MARK: - DataSource

//extension MenuViewController: PagingViewControllerDataSource {
//
//    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
//        return 10
//    }
//
//    func pagingViewController(_ pagingViewController: PagingViewController, viewControllerAt index: Int) -> UIViewController {
//        return UIViewController()
//    }
//
//    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
//
//    }
//}
