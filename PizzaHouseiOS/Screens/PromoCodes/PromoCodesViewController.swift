//
//  PromoCodesViewController.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 15.01.2022.
//

import UIKit
import SnapKit

private enum Constants {
    static let baseMargin: CGFloat = 16
    static let heightHeaderView: CGFloat = 44
    static let titleFont: UIFont = FontFamily.Montserrat.semiBold.font(size: 14)
    static let tableSpacing: CGRect = CGRect(x: 0, y: 0, width: 0, height: 8)
}

final class PromoCodesViewController: BaseViewController {
    
    // UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.PromoCodes.promoCodes
        label.font = Constants.titleFont
        label.textColor = Asset.mainBlack.color
        return label
    }()
    private lazy var headerView: UIView = {
        let view = UIView()
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.baseMargin)
            $0.centerY.equalToSuperview()
        }
        return view
    }()
    internal lazy var tableView = UITableView()
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        addViews()
        configureLayout()
        configureTableView()
        configureAppearance()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        configureLayout()
        
        // TODO: Нужно удалить
        showSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            self?.hideSkeleton()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    // MARK: - Private
    
    private func addViews() {
        view.addSubview(headerView)
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        headerView.snp.remakeConstraints {
            $0.height.equalTo(Constants.heightHeaderView)
            $0.top.equalToSuperview().inset(view.safeAreaInsets)
            $0.leading.trailing.equalToSuperview()
        }
        tableView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configureTableView() {
        tableView.register(PromoCodeCell.self, forCellReuseIdentifier: PromoCodeCell.identifier)
        tableView.register(PromoCodeSkeletonCell.self, forCellReuseIdentifier: PromoCodeSkeletonCell.identifier)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delaysContentTouches = false
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = UIView(frame: Constants.tableSpacing)
        tableView.tableFooterView = UIView(frame: Constants.tableSpacing)
    }
    
    private func configureAppearance() {
        view.backgroundColor = Asset.mainBackground.color
    }

}

// MARK: - TabBarItem

extension PromoCodesViewController: TabBarItem {
    
    var tabBarTitle: String? {
        L10n.PromoCodes.promoCodes
    }
    
    var tabBarImage: UIImage {
        Asset.iconPromoCodes.image
    }
}

// MARK: - DataSource TableView

extension PromoCodesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PromoCodeCell.identifier,
                for: indexPath) as? PromoCodeCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: .init(title: "В день рождения пицца в подарок!",
                                   description: "Промокод можно использовать в день рождения и 3 дня после, не чаще чем один раз в год. Акция не суммируется с другими акциями",
                                   promoCode: "HAPPYDAY",
                                   imageUrl: nil))
        let backView = UIView()
        backView.backgroundColor = .clear
        cell.selectedBackgroundView = backView
        return cell
    }
}
