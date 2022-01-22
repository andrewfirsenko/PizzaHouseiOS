//
//  MenuItemCell.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 22.01.2022.
//

import UIKit
import SnapKit
import Kingfisher

private enum Constants {
    static let scaleImageWidth: CGFloat = 0.27
    static func imageSize(frame: CGRect) -> CGFloat {
        frame.width * scaleImageWidth
    }
    static let horizontalMargin: CGFloat = 16
    static let verticalSpacing: CGFloat = 12
    static let compactMargin: CGFloat = 8
    static let smallMargin: CGFloat = 2
    static let nameLabelFond: UIFont = FontFamily.Montserrat.medium.font(size: 14)
    static let descriptionLabelFond: UIFont = FontFamily.Montserrat.regular.font(size: 12)
    static let amountButtonFond: UIFont = FontFamily.Montserrat.medium.font(size: 12)
    static let cartButtonFond: UIFont = FontFamily.Montserrat.semiBold.font(size: 13)
    static let imageColor: UIColor = .black.withAlphaComponent(0.3)
    static let pizzaDefault: UIImage = {
        Asset.pizzaDefault.image.withTintColor(Constants.imageColor,
                                               renderingMode: .alwaysOriginal)
    }()
    static let amountButtonWidth: CGFloat = 80
    static let buttonHeight: CGFloat = 24
}

final class MenuItemCell: UITableViewCell {
    
    // UI
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.compactMargin
        stackView.alignment = .center
        return stackView
    }()
    private lazy var descriptionContainer: UIView = UIView()
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.pizzaDefault
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.nameLabelFond
        label.textColor = Asset.mainBlack.color
        label.numberOfLines = 0
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.descriptionLabelFond
        label.textColor = Asset.mainBlack.color
        label.numberOfLines = 0
        return label
    }()
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.descriptionLabelFond
        label.textColor = Asset.mainBlack.color
        label.numberOfLines = 0
        return label
    }()
    private lazy var amountButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.buttonHeight / 2
        button.backgroundColor = Asset.orangeSecond.color
        button.setTitleColor(Asset.orangeBlack.color, for: .normal)
        button.titleLabel?.font = Constants.amountButtonFond
        button.isUserInteractionEnabled = false
        return button
    }()
    private lazy var cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = Constants.cartButtonFond
        button.setTitle(L10n.Menu.cartButton, for: .normal)
        button.setTitleColor(Asset.orange.color, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.setImage(Asset.iconCart.image, for: .normal)
        button.tintColor = Asset.orange.color
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(tapCart), for: .touchUpInside)
        return button
    }()
    
    // Public
    
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
    
    // MARK: - Lifecycle
    
    // MARK: - Actions
    
    @objc private func tapCart() {
        print("tap cart")
    }
    
    // MARK: - Private
    
    private func addViews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(productImageView)
        mainStackView.addArrangedSubview(descriptionContainer)
        
        descriptionContainer.addSubview(nameLabel)
        descriptionContainer.addSubview(descriptionLabel)
        descriptionContainer.addSubview(quantityLabel)
        descriptionContainer.addSubview(amountButton)
        descriptionContainer.addSubview(cartButton)
    }
    
    private func configureLayout() {
        mainStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Constants.verticalSpacing).priority(.high)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
        }
        productImageView.snp.makeConstraints {
            $0.width.height.equalTo(Constants.imageSize(frame: UIScreen.main.bounds))
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.smallMargin)
        }
        quantityLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(descriptionLabel.snp.bottom)
        }
        amountButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalTo(Constants.buttonHeight)
            $0.width.equalTo(Constants.amountButtonWidth)
            $0.top.equalTo(quantityLabel.snp.bottom).offset(Constants.compactMargin)
            $0.bottom.equalToSuperview()
        }
        cartButton.snp.makeConstraints {
            $0.leading.equalTo(amountButton.snp.trailing).offset(Constants.smallMargin)
            $0.trailing.bottom.equalToSuperview()
            $0.top.equalTo(amountButton.snp.top)
        }
    }
    
    private func configureAppearance() {
        backgroundColor = .clear
    }
}

// MARK: - Configurable

extension MenuItemCell: Configurable {
    
    func configure(with model: MenuItemModel) {
        productImageView.kf.setImage(with: model.imageUrl,
                               placeholder: Constants.pizzaDefault)
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        quantityLabel.text = model.quantity
        amountButton.setTitle("\(model.amount) ₽", for: .normal)
    }
}
