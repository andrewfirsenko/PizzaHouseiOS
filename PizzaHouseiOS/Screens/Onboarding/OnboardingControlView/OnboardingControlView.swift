//
//  OnboardingControlView.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 11.01.2022.
//

import UIKit
import SnapKit

protocol IOnboardingControlView: UIView {
    
    /// Устанавливает количесво шагов
    func configure(with count: Int)
    
    /// Устанавливает текущий шаг
    func selectStep(with step: Int)
    
    /// Сообщает об текущем выбраном шаге
    var onSelectedStep: ((Int) -> Void)? { get set }
}

private extension CGFloat {
    static let iconSize: CGFloat = 18
    static let buttonSize: CGFloat = 60
    static let horizontalMargin: CGFloat = 30
}

final class OnboardingControlView: UIView, IOnboardingControlView {
    
    // UI
    private var prevButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.arrawLeft.image, for: .normal)
        button.tintColor = Asset.mainBlack.color
        button.isHidden = true
        return button
    }()
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.arrawRight.image, for: .normal)
        button.tintColor = .red
        return button
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        addViews()
        configureLayout()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func addViews() {
        addSubview(prevButton)
        addSubview(nextButton)
    }
    
    private func configureLayout() {
        prevButton.snp.makeConstraints {
            $0.width.height.equalTo(CGFloat.buttonSize)
            $0.top.bottom.greaterThanOrEqualToSuperview()
            $0.left.equalToSuperview().offset(CGFloat.horizontalMargin)
        }
        nextButton.snp.makeConstraints {
            $0.width.height.equalTo(CGFloat.buttonSize)
            $0.top.bottom.greaterThanOrEqualToSuperview()
            $0.right.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    private func configureAppearance() {
        backgroundColor = .clear
    }
    
    // MARK: - IOnboardingControlView
    
    var onSelectedStep: ((Int) -> Void)?
    
    func selectStep(with step: Int) {
        // TODO
    }
    
    func configure(with count: Int) {
        // TODO
    }
}
