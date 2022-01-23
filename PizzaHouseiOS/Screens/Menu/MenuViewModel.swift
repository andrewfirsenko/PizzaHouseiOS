//
//  MenuViewModel.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 22.01.2022.
//

import Foundation

final class MenuViewModel {
    
    var categories: [CategoryModel] = [
        .init(category: 1, title: "Пицца", image: Asset.sous.image),
        .init(category: 2, title: "Роллы", image: Asset.sous.image),
        .init(category: 3, title: "Напитки", image: Asset.sous.image),
        .init(category: 4, title: "Fast food", image: Asset.sous.image),
        .init(category: 5, title: "Соусы", image: Asset.sous.image),
        .init(category: 6, title: "Пицца6", image: Asset.sous.image),
        .init(category: 7, title: "Пицца7", image: Asset.sous.image),
        .init(category: 8, title: "Пицца8", image: Asset.sous.image)
    ]
}
