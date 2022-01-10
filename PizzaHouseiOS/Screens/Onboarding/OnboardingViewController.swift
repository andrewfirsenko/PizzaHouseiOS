//
//  OnboardingViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 11.01.2022.
//

import Foundation
import UIKit

final class OnboardingViewController: BaseViewController {
    
    // UI
    private let pageViewController = UIPageViewController()
    private let controlView: IOnboardingControlView
    
    // MARK: - Init
    
    init(controlView: IOnboardingControlView) {
        self.controlView = controlView
        super.init()
        
        addViews()
        configureLayout()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func addViews() {
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        view.addSubview(pageViewController.view)
        view.addSubview(controlView)
    }
    
    private func configureLayout() {
        
    }
    
    private func configureAppearance() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        view.backgroundColor = .red
    }
}

// MARK: - UIPageViewControllerDataSource

extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        nil
    }
}

// MARK: - UIPageViewControllerDelegate

extension OnboardingViewController: UIPageViewControllerDelegate {
    
}
