//
//  MenuCategoryPagingCell.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 22.01.2022.
//

import UIKit
import SnapKit
import Parchment

private enum Constants {
    static let titleFont: UIFont = FontFamily.Montserrat.semiBold.font(size: 11)
    static let cornerRadius: CGFloat = 4
    static let topMargin: CGFloat = 6
    static let compactMargin: CGFloat = 4
}

class MenuCategoryPagingCell: PagingCell {
    
    private lazy var skeletonView = UIView()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleFont
        label.textColor = Asset.blackLight.color
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    // Public
    public static var identifier: String {
        String(describing: self)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        configureLayout()
        configureAppearance()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func setPagingItem(_ pagingItem: PagingItem, selected: Bool, options _: PagingOptions) {
        guard let item = pagingItem as? CategoryModel else { return }
        
        imageView.image = item.image.withTintColor(Asset.blackLight.color, renderingMode: .alwaysOriginal)
        titleLabel.text = item.title

        if selected {
            contentView.backgroundColor = Asset.orangeSecond.color
        } else {
            contentView.backgroundColor = Asset.mainBackground.color
        }
    }

    open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        if let attributes = layoutAttributes as? PagingCellLayoutAttributes {
            contentView.backgroundColor =
                .transitionColor(fromColor: Asset.mainBackground.color,
                                 toColor: Asset.orangeSecond.color,
                                 progress: attributes.progress)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
    }
    
    // MARK: - Private
    
    private func addViews() {
        contentView.addSubview(skeletonView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    private func configureLayout() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.topMargin)
            $0.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(Constants.compactMargin)
            $0.bottom.equalToSuperview().inset(Constants.compactMargin)
        }
        skeletonView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureAppearance() {
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.clipsToBounds = true
        
        configureSkeletonAppearance()
    }
    
    private func configureSkeletonAppearance() {
        isSkeletonable = true
        contentView.isSkeletonable = true
        skeletonView.isSkeletonable = true
        skeletonView.skeletonCornerRadius = Float(Constants.cornerRadius)
        
        layoutIfNeeded()
    }
}
