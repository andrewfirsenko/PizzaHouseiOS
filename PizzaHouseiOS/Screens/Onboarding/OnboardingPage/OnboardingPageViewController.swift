//
//  OnboardingPageViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 13.01.2022.
//

import UIKit
import SnapKit

private extension CGFloat {
    static let horizontalMargin: CGFloat = 24
    static let bottomMargin: CGFloat = 40
    static let betweenTextMargin: CGFloat = 32
    
    static let titleFontSize: CGFloat = 24
    static let secondTextFondSize: CGFloat = 14
}

final class OnboardingPageViewController: BaseViewController {
    
    // UI
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let secondTextLabel = UILabel()
    
    // Public property
    private(set) var index: Int?
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        addViews()
        configureLayout()
        configureAppearance()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func addViews() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(secondTextLabel)
    }
    
    private func configureLayout() {
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            $0.top.equalTo(imageView.snp.bottom)
        }
        secondTextLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            $0.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.betweenTextMargin)
            $0.bottom.equalToSuperview().inset(CGFloat.bottomMargin)
        }
    }
    
    private func configureAppearance() {
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = FontFamily.JosefinSans.semiBold.font(size: CGFloat.titleFontSize)
        titleLabel.textColor = Asset.orange.color
        
        secondTextLabel.numberOfLines = 0
        secondTextLabel.textAlignment = .center
        secondTextLabel.font = FontFamily.Montserrat.semiBold.font(size: CGFloat.secondTextFondSize)
        secondTextLabel.textColor = Asset.gray.color
    }
}

// MARK: - Configurable

extension OnboardingPageViewController: Configurable {
    
    struct Model {
        let index: Int
        let image: UIImage
        let title: String
        let secondText: String
    }
    
    func configure(with model: Model) {
        self.index = model.index
        self.imageView.image = model.image
        self.titleLabel.text = model.title.uppercased()
        self.secondTextLabel.text = model.secondText
    }
}

