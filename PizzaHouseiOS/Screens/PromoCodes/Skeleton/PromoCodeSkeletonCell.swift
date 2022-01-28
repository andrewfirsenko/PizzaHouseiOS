//
//  PromoCodeSkeletonCell.swift
//  PizzaHouseiOS
//
//  Created by Andrew on 25.01.2022.
//

import UIKit
import SnapKit

private extension CGFloat {
    static let verticalMargin: CGFloat = 6
}

final class PromoCodeSkeletonCell: UITableViewCell {
    
    // UI
    private lazy var container = UIView()
    
    // Public property
    public static var identifier: String {
        String(describing: self)
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        configureLayout()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func addViews() {
        contentView.addSubview(container)
    }
    
    private func configureLayout() {
        container.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(CGFloat.smallMargin)
            $0.top.bottom.equalToSuperview().inset(CGFloat.verticalMargin)
        }
    }
    
    private func configureAppearance() {
        backgroundColor = .clear
        isSkeletonable = true
        container.isSkeletonable = true
        container.skeletonCornerRadius = Float(CGFloat.smallRadius)
    }
    
}
