//
//  MenuViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 15.01.2022.
//

import UIKit
import SnapKit
import Parchment

private enum Constants {
    static let baseMargin: CGFloat = 16
    static let heightHeaderView: CGFloat = 44
    
    /// Количество видимых элементов на экране
    /// От этого параметра зависит ширина\высота menuItem
    static let visibleItems: CGFloat = 4.7
    static let menuInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    static let menuItemSpacing: CGFloat = 6
    
    static func menuItemSize(frame: CGRect) -> CGSize {
        var width: CGFloat = frame.width - Constants.menuInsets.left
        width -= CGFloat(Int(Constants.visibleItems)) * Constants.menuItemSpacing
        width /= Constants.visibleItems
        return CGSize(width: width, height: width * 0.8)
    }
}

final class MenuViewController: BaseViewController {
    
    // UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Menu.menu
        return label
    }()
    private lazy var headerView: UIView = {
        let view = UIView()
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.baseMargin)
            $0.centerY.equalToSuperview()
        }
        return view
    }()
    private lazy var pagingViewController = PagingViewController()
    
    // Private property
    private let viewModel = MenuViewModel()
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        addViews()
        configureLayout()
        configurePagingController()
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
        view.addSubview(headerView)
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
    }
    
    private func configureLayout() {
        headerView.snp.removeConstraints()
        pagingViewController.view.snp.removeConstraints()
        
        headerView.snp.makeConstraints {
            $0.height.equalTo(Constants.heightHeaderView)
            $0.top.equalToSuperview().inset(view.safeAreaInsets)
            $0.leading.trailing.equalToSuperview()
        }
        pagingViewController.view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalToSuperview().inset(view.safeAreaInsets)
        }
    }
    
    private func configurePagingController() {
        pagingViewController.register(ImagePagingCell.self, for: CategoryModel.self)
        pagingViewController.dataSource = self
        
        let menuItemSize = Constants.menuItemSize(frame: view.frame)
        pagingViewController.menuItemSize = .fixed(width: menuItemSize.width,
                                                   height: menuItemSize.height)
        pagingViewController.menuItemSpacing = Constants.menuItemSpacing
        pagingViewController.menuInsets = Constants.menuInsets
        
        pagingViewController.indicatorOptions = .hidden
        pagingViewController.borderOptions = .hidden
        
        pagingViewController.select(pagingItem: viewModel.categories.first!)
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

extension MenuViewController: PagingViewControllerDataSource {

    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return viewModel.categories.count
    }

    func pagingViewController(_ pagingViewController: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        return PageMenuViewController()
    }

    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        viewModel.categories[index]
    }
}
