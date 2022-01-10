//
//  OnboardingControlView.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 11.01.2022.
//

import Foundation
import UIKit

protocol IOnboardingControlView: UIView {
    
    /// Устанавливает количесво шагов
    func configure(with count: Int)
    
    /// Устанавливает текущий шаг
    func selectIndex(with index: Int)
    
    /// Сообщает об текущем выбраном шаге
    var onSelectedIndex: ((Int) -> Void)? { get set }
}

final class OnboardingControlView: UIView, IOnboardingControlView {
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    func addViews() {
        
    }
    
    // MARK: - IOnboardingControlView
    
    var onSelectedIndex: ((Int) -> Void)?
    
    func selectIndex(with index: Int) {
        // TODO
    }
    
    func configure(with count: Int) {
        // TODO
    }
}
