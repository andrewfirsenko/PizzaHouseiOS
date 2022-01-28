//
//  MenuSkeletonView.swift
//  PizzaHouseiOS
//
//  Created by Andrew on 25.01.2022.
//

import UIKit
import SnapKit
import SkeletonView

private enum Constants {
    static let visibleItems: CGFloat = 4.7
    static let menuInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    static let menuItemSpacing: CGFloat = 6
    static func menuItemSize(frame: CGRect) -> CGSize {
        var width: CGFloat = frame.width - Constants.menuInsets.left
        width -= CGFloat(Int(Constants.visibleItems)) * Constants.menuItemSpacing
        width /= Constants.visibleItems
        return CGSize(width: width, height: width * 0.8)
    }
    static let tableTopInsets: CGFloat = 6
}

protocol IMenuSkeletonView: AnyObject {
    
    func showSkeleton()
    func hideSkeleton()
}

final class MenuSkeletonView: UIView, IMenuSkeletonView {
    
    // UI
    private lazy var skeletonCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private lazy var skeletonTableView = UITableView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        configureLayout()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - IMenuSkeletonView
    
    func showSkeleton() {
        skeletonTableView.isSkeletonable = true
        skeletonTableView.showAnimatedSkeleton(animation: { _ in
            CABasicAnimation.skeletonAnimation
        })
        skeletonCollectionView.isSkeletonable = true
        skeletonCollectionView.showAnimatedSkeleton(animation: { _ in
            CABasicAnimation.skeletonAnimation
        })
    }
    
    func hideSkeleton() {
        skeletonTableView.hideSkeleton()
        skeletonCollectionView.hideSkeleton()
    }
    
    // MARK: - Private
    
    func addViews() {
        addSubview(skeletonCollectionView)
        addSubview(skeletonTableView)
    }
    
    func configureLayout() {
        let size = Constants.menuItemSize(frame: UIScreen.main.bounds)
        skeletonCollectionView.snp.makeConstraints {
            $0.height.equalTo(size.height)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        skeletonTableView.snp.makeConstraints {
            $0.top.equalTo(skeletonCollectionView.snp.bottom).offset(Constants.tableTopInsets)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configureAppearance() {
        skeletonTableView.register(MenuItemCell.self, forCellReuseIdentifier: MenuItemCell.identifier)
        skeletonTableView.dataSource = self
        skeletonTableView.rowHeight = UITableView.automaticDimension
        skeletonTableView.estimatedRowHeight = 150
        skeletonTableView.backgroundColor = .clear
        skeletonTableView.separatorStyle = .none
        skeletonTableView.showsVerticalScrollIndicator = false
        
        skeletonCollectionView.register(MenuCategoryPagingCell.self,
                                        forCellWithReuseIdentifier: MenuCategoryPagingCell.identifier)
        skeletonCollectionView.dataSource = self
        skeletonCollectionView.delegate = self
        skeletonCollectionView.backgroundColor = .clear
        skeletonCollectionView.contentInset = Constants.menuInsets
    }
}

// MARK: - DataSouce

extension MenuSkeletonView: SkeletonTableViewDataSource, SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Skeleton
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        guard
            let cell = skeletonView.dequeueReusableCell(
                withIdentifier: MenuItemCell.identifier,
                for: indexPath) as? MenuItemCell
        else {
            return UITableViewCell()
        }
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        guard
            let cell = skeletonView.dequeueReusableCell(
                withReuseIdentifier: MenuCategoryPagingCell.identifier,
                for: indexPath) as? MenuCategoryPagingCell
        else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        MenuCategoryPagingCell.identifier
    }
    
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        cellIdentifierForRowAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        MenuItemCell.identifier
    }
    
    // Default
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = Constants.menuItemSize(frame: collectionView.bounds)
        return CGSize(width: size.width, height: size.height)
    }
}
