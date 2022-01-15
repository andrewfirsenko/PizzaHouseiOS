//
//  OnboardingViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 11.01.2022.
//

import UIKit
import SnapKit

private extension CGFloat {
    static let minBottomMargin: CGFloat = 24
}

protocol IOnboardingViewController: AnyObject {
    
    /// Сообщает о завершении прохождения всех шагов
    var onCompleted: (() -> Void)? { set get }
}

final class OnboardingViewController: BaseViewController, IOnboardingViewController {
    
    // Dependensis
    private let viewModel: IOnboardingViewModel
    
    // UI
    private let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                          navigationOrientation: .horizontal)
    private let controlView: IOnboardingControlView
    
    // Private property
    private var pages: [OnboardingPageViewController] = []
    private var currentIndex: Int?
    
    // IOnboardingViewController
    var onCompleted: (() -> Void)? {
        didSet {
            controlView.onCompleted = onCompleted
        }
    }
    
    // MARK: - Init
    
    init(
        controlView: IOnboardingControlView,
        viewModel: IOnboardingViewModel
    ) {
        self.controlView = controlView
        self.viewModel = viewModel
        super.init()
        
        addViews()
        configureActions()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePageViewController()
        controlView.configure(with: pages.count)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    // MARK: - Private
    
    private func addViews() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        view.addSubview(controlView)
    }
    
    private func configureLayout() {
        pageViewController.view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(view.safeAreaInsets.top)
            $0.bottom.greaterThanOrEqualTo(controlView.snp.top)
        }
        controlView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(max(view.safeAreaInsets.bottom, CGFloat.minBottomMargin))
        }
    }
    
    private func configureAppearance() {
        view.backgroundColor = Asset.mainBackground.color
    }
    
    private func configurePageViewController() {
        pages = viewModel.data.map {
            let page = OnboardingPageViewController()
            page.configure(with: $0)
            return page
        }
        if let firstPage = pages.first {
            currentIndex = 0
            pageViewController.setViewControllers([firstPage], direction: .forward, animated: false, completion: nil)
        }
    }
    
    // MARK: - Actions
    
    private func configureActions() {
        controlView.onSelectedStep = { [weak self] newStep in
            let index = newStep - 1
            guard
                let self = self,
                index >= 0 && index < self.pages.count,
                let currentIndex = self.currentIndex
            else {
                return
            }
            self.pageViewController.setViewControllers(
                [self.pages[index]],
                direction: currentIndex < index ? .forward : .reverse,
                animated: true,
                completion: nil
            )
            self.currentIndex = index
        }
    }
}
