//
//  Skeleton+Animation.swift
//  PizzaHouseiOS
//
//  Created by Andrew on 25.01.2022.
//

import UIKit

extension CABasicAnimation {
    
    static let skeletonAnimation: CABasicAnimation = {
        let darkerColor = Asset.skeletonMainColor.color
        let lighterColor = Asset.skeletonSecondColor.color
        let pulseAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.backgroundColor))

        //  Changes
        pulseAnimation.fromValue = darkerColor.cgColor
        pulseAnimation.toValue = lighterColor.cgColor

        pulseAnimation.duration = 0.75
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        pulseAnimation.isRemovedOnCompletion = false
        
        return pulseAnimation
    }()
}
