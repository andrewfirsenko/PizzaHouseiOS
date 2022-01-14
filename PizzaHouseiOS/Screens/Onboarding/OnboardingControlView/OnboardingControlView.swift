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
    func selectStep(with step: Int, animated: Bool)
    
    /// Сообщает об текущем выбраном шаге
    var onSelectedStep: ((Int) -> Void)? { get set }
    
    /// Сообщает о завершении прохождения всех шагов
    var onCompleted: (() -> Void)? { get set }
}

private enum Constants {
    static let horizontalMargin: CGFloat = 30
    static let buttonSize: CGFloat = 60
    static let buttonRect = CGRect(origin: .zero,
                                   size: CGSize(width: Constants.buttonSize, height: Constants.buttonSize))
}

final class OnboardingControlView: UIView, IOnboardingControlView {
    
    // UI
    private lazy var prevButton: UIButton = {
        let button = UIButton(frame: Constants.buttonRect)
        button.setImage(Asset.arrawLeft.image, for: .normal)
        button.tintColor = Asset.mainBlack.color
        button.isHidden = false
        button.addTarget(self, action: #selector(tapPrevButton), for: .touchUpInside)
        return button
    }()
    private lazy var nextButton: CircleProgressButton = {
        let button = CircleProgressButton(frame: Constants.buttonRect)
        button.setImage(Asset.arrawRight.image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        return button
    }()
    
    // Private property
    private var countSteps: Int = 1
    private var currentStep: Int = 1
    
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
            $0.width.height.equalTo(Constants.buttonSize)
            $0.top.lessThanOrEqualToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.horizontalMargin)
        }
        nextButton.snp.makeConstraints {
            $0.width.height.equalTo(Constants.buttonSize)
            $0.top.lessThanOrEqualToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Constants.horizontalMargin)
        }
    }
    
    private func configureAppearance() {
        backgroundColor = .clear
    }
    
    private func updateUI(animated: Bool) {
        prevButton.isHidden = currentStep <= 1
        nextButton.setProgress(with: CGFloat(currentStep) / CGFloat(countSteps), animated: animated)
    }
    
    // MARK: - Actions
    
    @objc private func tapPrevButton() {
        let step = max(1, currentStep - 1)
        selectStep(with: step, animated: true)
        onSelectedStep?(step)
    }
    
    @objc private func tapNextButton() {
        if countSteps == currentStep {
            onCompleted?()
            return
        }
        let step = min(countSteps, currentStep + 1)
        selectStep(with: step, animated: true)
        onSelectedStep?(step)
    }
    
    // MARK: - IOnboardingControlView
    
    var onSelectedStep: ((Int) -> Void)?
    var onCompleted: (() -> Void)?
    
    func selectStep(with step: Int, animated: Bool) {
        guard step > 0 && step <= countSteps else {
            return
        }
        currentStep = step
        updateUI(animated: animated)
    }
    
    func configure(with count: Int) {
        countSteps = count > 0 ? count : 1
        selectStep(with: 1, animated: false)
    }
}
