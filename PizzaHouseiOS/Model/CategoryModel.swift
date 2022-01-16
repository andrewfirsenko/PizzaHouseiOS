//
//  CategoryModel.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 16.01.2022.
//

import Foundation
import Parchment

struct CategoryModel: PagingItem, Hashable, Comparable {
    
    let category: UInt
    let title: String
    let image: UIImage

    static func < (lhs: CategoryModel, rhs: CategoryModel) -> Bool {
        return lhs.category < rhs.category
    }
}
