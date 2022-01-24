//
//  PromoCodeCell.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 23.01.2022.
//

import UIKit
import SnapKit
import Kingfisher
import Toast_Swift

private enum Constants {
    static let dashPattern: [NSNumber] = [6, 3]
    
    static let buttonInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    static let normalMargin: CGFloat = 12
    static let horizontalMargin: CGFloat = 8
    static let verticalMargin: CGFloat = 6
    static let cornerRadius: CGFloat = 6
    static let heightImage: CGFloat = {
        (UIScreen.main.bounds.width - 2 * horizontalMargin) * 0.4
    }()
    static let heightButton: CGFloat = 32
    
    static let titleFont = FontFamily.Montserrat.semiBold.font(size: 15)
    static let descriptionFont = FontFamily.Montserrat.regular.font(size: 11)
    static let promoCodeFont = FontFamily.Montserrat.medium.font(size: 12)
    static let copyFont = FontFamily.Montserrat.bold.font(size: 12)
    static let promoCodeValueFont = FontFamily.Montserrat.bold.font(size: 18)
}

final class PromoCodeCell: UITableViewCell {
    
    // UI
    private lazy var container = UIView()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.horizontalMargin
        return stackView
    }()
    private lazy var promoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.normalMargin
        return stackView
    }()
    
    private lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleFont
        label.textColor = Asset.mainBlack.color
        label.numberOfLines = 0
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.descriptionFont
        label.textColor = Asset.mainBlack.color
        label.numberOfLines = 0
        return label
    }()
    private lazy var promoCodeLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.promoCodeFont
        label.textColor = Asset.mainBlack.color
        label.numberOfLines = 1
        label.text = L10n.PromoCodes.promoCode
        return label
    }()
    private lazy var promoButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = Constants.copyFont
        button.setTitle(L10n.PromoCodes.copy.uppercased(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Asset.orange.color
        button.layer.cornerRadius = Constants.cornerRadius
        button.contentEdgeInsets = Constants.buttonInsets
        button.addTarget(self, action: #selector(tapCopy), for: .touchUpInside)
        return button
    }()
    private lazy var promoCodeValueLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.promoCodeValueFont
        label.textColor = Asset.mainBlack.color
        label.textAlignment = .center
        label.numberOfLines = 1
        label.layer.cornerRadius = Constants.cornerRadius
        return label
    }()
    private lazy var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = Asset.gray.color.cgColor
        layer.lineDashPattern = Constants.dashPattern
        layer.fillColor = nil
        layer.lineWidth = 1
        promoCodeValueLabel.layer.addSublayer(layer)
        return layer
    }()
    
    // Private property
    private var model: PromoCodeModel?
    
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
    
    // MARK: - Lifecycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        borderLayer.frame = promoCodeValueLabel.bounds
        borderLayer.path = UIBezierPath(
            roundedRect: promoCodeValueLabel.bounds,
            cornerRadius: promoCodeValueLabel.layer.cornerRadius
        ).cgPath
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        infoImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        promoCodeValueLabel.text = nil
    }
    
    // MARK: - Actions
    
    @objc private func tapCopy() {
        UIPasteboard.general.string = model?.promoCode.uppercased()
        UIApplication.shared.windows.first { $0.isKeyWindow }?
            .makeToast(L10n.PromoCodes.promoCodeSaved,
                       duration: 1.0,
                       position: .bottom)
    }
    
    // MARK: - Private
    
    private func addViews() {
        contentView.addSubview(container)
        container.addSubview(infoImageView)
        container.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(promoCodeLabel)
        stackView.addArrangedSubview(promoStackView)
        
        promoStackView.addArrangedSubview(promoCodeValueLabel)
        promoStackView.addArrangedSubview(promoButton)
    }
    
    private func configureLayout() {
        container.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
            $0.top.bottom.equalToSuperview().inset(Constants.verticalMargin)
        }
        infoImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constants.heightImage)
            $0.top.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.normalMargin)
            $0.top.equalTo(infoImageView.snp.bottom).offset(Constants.normalMargin)
            $0.bottom.equalToSuperview().inset(Constants.normalMargin)
        }
        // Button
        promoButton.snp.makeConstraints {
            $0.height.equalTo(Constants.heightButton)
        }
        promoCodeValueLabel.snp.makeConstraints {
            $0.height.equalTo(Constants.heightButton)
            $0.width.greaterThanOrEqualTo(Constants.heightButton)
        }
    }
    
    private func configureAppearance() {
        backgroundColor = .clear
        container.backgroundColor = .white
        container.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        container.layer.shadowOpacity = 1
        container.layer.shadowRadius = 2
        container.layer.shadowOffset = CGSize(width: 0, height: 1)
        container.clipsToBounds = false
        container.layer.cornerRadius = Constants.cornerRadius
    }
    
}

// MARK: - Configurable

extension PromoCodeCell: Configurable {
    
    func configure(with model: PromoCodeModel) {
        self.model = model
        
        infoImageView.kf.setImage(with: model.imageUrl,
                                  placeholder: Asset.promoDebug.image)
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        promoCodeValueLabel.text = model.promoCode.uppercased()
    }
}
