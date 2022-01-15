//
//  UserDefaults+Extensions.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 15.01.2022.
//

import Foundation

extension UserDefaults {
    
    // MARK: - Onboarding
    
    var wasOnboarding: Bool? {
        set {
            set(newValue, forKey: #function)
        }
        get {
            return value(forKey: #function) as? Bool
        }
    }
}
