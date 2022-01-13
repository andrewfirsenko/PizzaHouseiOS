//
//  OnboardingViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 11.01.2022.
//

import UIKit
import SnapKit

final class OnboardingViewController: BaseViewController {
    
    // Dependensis
    private let controlView: IOnboardingControlView
    private let viewModel: IOnboardingViewModel
    
    // UI
    private let pageViewController = UIPageViewController()
    
    // Private property
    private var pages: [OnboardingPageViewController] = []
    
    // MARK: - Init
    
    init(
        controlView: IOnboardingControlView,
        viewModel: IOnboardingViewModel
    ) {
        self.controlView = controlView
        self.viewModel = viewModel
        super.init()
        
        addViews()
        configureViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController.view.backgroundColor = .red
        pageViewController.setViewControllers(pages, direction: .forward, animated: true) { completed in
            if !completed { return }
            DispatchQueue.main.async { [weak self] in
                self?.pageViewController.dataSource = nil
                self?.pageViewController.dataSource = self
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureLayout()
    }
    
    // MARK: - Private
    
    private func addViews() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        view.addSubview(controlView)
    }
    
    private func configureViews() {
        pageViewController.dataSource = self
        
        pages = viewModel.data.map {
            let page = OnboardingPageViewController()
            page.configure(with: $0)
            return page
        }
        controlView.configure(with: pages.count)
    }
    
    private func configureLayout() {
        pageViewController.view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(controlView.snp.top)
        }
        controlView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
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
         pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = (viewController as? OnboardingPageViewController)?.index else {
            return nil
        }
        let prevIndex = index - 1
        guard prevIndex > 0 else {
            return nil
        }
        return pages[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = (viewController as? OnboardingPageViewController)?.index else {
            return nil
        }
        let nextIndex = index + 1
        guard nextIndex < pages.count else {
            return nil
        }
        return pages[nextIndex]
    }
}
