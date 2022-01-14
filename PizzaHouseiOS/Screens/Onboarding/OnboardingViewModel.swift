//
//  OnboardingViewModel.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 13.01.2022.
//

import Foundation

protocol IOnboardingViewModel {
    
    var data: [OnboardingPageViewController.Model] { get }
}

final class OnboardingViewModel: IOnboardingViewModel {
    
    let data: [OnboardingPageViewController.Model] = [
        .init(index: 0,
              image: Asset.startMobileApp.image,
              title: L10n.Onboarding.OnlineOrder.title,
              secondText: L10n.Onboarding.OnlineOrder.secondText),
        .init(index: 1,
              image: Asset.startPizza.image,
              title: L10n.Onboarding.TystyPizza.title,
              secondText: L10n.Onboarding.TystyPizza.secondText),
        .init(index: 2,
              image: Asset.startDelivery.image,
              title: L10n.Onboarding.Delivery.title,
              secondText: L10n.Onboarding.Delivery.secondText)
    ]
}
