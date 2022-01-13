//
//  OnboardingPageViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 13.01.2022.
//

import UIKit
import SnapKit

final class OnboardingPageViewController: BaseViewController {
    
    // UI
    
    // Public property
    private(set) var index: Int?
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        view.backgroundColor = .green
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    
    
    
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
    }
}

