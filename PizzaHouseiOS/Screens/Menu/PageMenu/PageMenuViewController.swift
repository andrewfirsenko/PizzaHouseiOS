//
//  PageMenuViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 22.01.2022.
//

import UIKit
import SnapKit

final class PageMenuViewController: BaseViewController {
    
    // UI
    private lazy var centerVeiw: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
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
        view.addSubview(centerVeiw)
    }
    
    private func configureLayout() {
        centerVeiw.snp.makeConstraints {
            $0.height.width.equalTo(44)
            $0.center.equalToSuperview()
        }
    }
    
    private func configureAppearance() {
        
    }
}
