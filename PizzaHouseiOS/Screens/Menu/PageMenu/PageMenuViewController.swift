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
    private lazy var tableView = UITableView()
    
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
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureAppearance() {
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: MenuItemCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delaysContentTouches = false
        tableView.showsVerticalScrollIndicator = false
    }
}

// MARK: - DataSource TableView

extension PageMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemCell.identifier,
                                                     for: indexPath) as? MenuItemCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: .init(name: "Пепперони",
                                   description: "Фирменный соус, пепперони, шампиньоны, моцарелла, зелень",
                                   quantity: "700 гр.",
                                   amount: 420,
                                   imageUrl: nil))
        let backView = UIView()
        backView.backgroundColor = .clear
        cell.selectedBackgroundView = backView
        return cell
    }
}

// MARK: - Delegate TableView

extension PageMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("tap \(indexPath.row)")
    }
}
