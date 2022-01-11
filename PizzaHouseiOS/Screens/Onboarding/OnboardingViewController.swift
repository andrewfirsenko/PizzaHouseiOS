//
//  OnboardingViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 11.01.2022.
//

import UIKit
import SnapKit

final class OnboardingViewController: BaseViewController {
    
    // UI
    private let pageViewController = UIPageViewController()
    private let controlView: IOnboardingControlView
    
    // MARK: - Init
    
    init(controlView: IOnboardingControlView) {
        self.controlView = controlView
        super.init()
        
        addViews()
        configureViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureLayout()
    }
    
    // MARK: - Private
    
    private func addViews() {
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        view.addSubview(pageViewController.view)
        view.addSubview(controlView)
    }
    
    private func configureViews() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    private func configureLayout() {
        controlView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(view.safeAreaInsets.bottom)
        }
    }
    
    private func configureAppearance() {
        view.backgroundColor = Asset.mainBackground.color
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
