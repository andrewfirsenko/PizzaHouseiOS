//
//  PromoCodesViewController+Skeleton.swift
//  PizzaHouseiOS
//
//  Created by Andrew on 25.01.2022.
//

import SkeletonView

extension PromoCodesViewController: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        cellIdentifierForRowAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        return PromoCodeSkeletonCell.identifier
    }
    
    func showSkeleton() {
        tableView.isSkeletonable = true
        tableView.showAnimatedSkeleton(animation: { _ in
            CABasicAnimation.skeletonAnimation
        }, transition: .none)
    }
    
    func hideSkeleton() {
        tableView.hideSkeleton()
    }
}
