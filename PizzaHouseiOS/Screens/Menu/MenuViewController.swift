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
    static let titleFont: UIFont = FontFamily.Montserrat.semiBold.font(size: 14)
}

final class MenuViewController: BaseViewController {
    
    // UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Menu.menu
        label.font = Constants.titleFont
        label.textColor = Asset.mainBlack.color
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
    private lazy var skeletonView = MenuSkeletonView()
    
    // Private property
    private let viewModel = MenuViewModel()
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        addViews()
        configureLayout()
        configurePagingController()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagingViewController.select(pagingItem: viewModel.categories.first!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        configureLayout()
        
        // TODO: Нужно удалить
        showSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            self?.hideSkeleton()
        }
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
        
        view.addSubview(skeletonView)
    }
    
    private func configureLayout() {
        headerView.snp.remakeConstraints {
            $0.height.equalTo(Constants.heightHeaderView)
            $0.top.equalToSuperview().inset(view.safeAreaInsets)
            $0.leading.trailing.equalToSuperview()
        }
        pagingViewController.view.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalToSuperview().inset(view.safeAreaInsets)
        }
        skeletonView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalToSuperview().inset(view.safeAreaInsets)
        }
    }
    
    private func configurePagingController() {
        pagingViewController.register(MenuCategoryPagingCell.self, for: CategoryModel.self)
        pagingViewController.dataSource = self
        
        let menuItemSize = Constants.menuItemSize(frame: view.frame)
        pagingViewController.menuItemSize = .fixed(width: menuItemSize.width,
                                                   height: menuItemSize.height)
        pagingViewController.menuItemSpacing = Constants.menuItemSpacing
        pagingViewController.menuInsets = Constants.menuInsets
        pagingViewController.menuBackgroundColor = Asset.mainBackground.color
        
        pagingViewController.indicatorOptions = .hidden
        pagingViewController.borderOptions = .hidden
    }
    
    private func configureAppearance() {
        view.backgroundColor = Asset.mainBackground.color
        skeletonView.isHidden = true
    }
    
    // MARK: Skeleton
    
    func showSkeleton() {
        pagingViewController.view.isHidden = true
        skeletonView.isHidden = false
        skeletonView.showSkeleton()
    }
    
    func hideSkeleton() {
        pagingViewController.view.isHidden = false
        skeletonView.isHidden = true
        skeletonView.hideSkeleton()
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
