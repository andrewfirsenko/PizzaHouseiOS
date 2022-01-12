//
//  CircleProgressButton.swift
//  PizzaHouseiOS
//
//  Created by Andrew Firsenko on 12.01.2022.
//

import UIKit
import SnapKit

private enum Constants {
    static let lineWidth: CGFloat = 2
    static let spacing: CGFloat = 4
    static let startPoint: CGFloat = -Double.pi / 2
    static let endPoint: CGFloat = 3 * Double.pi / 2
    
    static let durationAnimation: CFTimeInterval = 0.3
}

protocol ICircleProgressButton: AnyObject {
    
    /// Устанавливает прогресс. Значение от 0 до 1
    func setProgress(with progress: CGFloat, animated: Bool)
}

final class CircleProgressButton: UIButton, ICircleProgressButton {
    
    // UI
    private lazy var circleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let radius = (frame.size.width / 2) - Constants.lineWidth - Constants.spacing
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: Constants.startPoint,
            endAngle: Constants.endPoint,
            clockwise: true
        )
        layer.path = path.cgPath
        layer.fillColor = Asset.orange.color.cgColor
        return layer
    }()
    private lazy var circleProgressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let radius = (frame.size.width / 2) - Constants.lineWidth
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: Constants.startPoint,
            endAngle: Constants.endPoint,
            clockwise: true
        )
        layer.path = path.cgPath
        layer.strokeEnd = .zero
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        layer.lineWidth = Constants.lineWidth
        layer.strokeColor = Asset.orange.color.cgColor
        return layer
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ICircleProgressButton
    
    func setProgress(with progress: CGFloat, animated: Bool) {
        guard progress >= 0 && progress <= 1 else { return }
        
        if animated {
            let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
            circularProgressAnimation.duration = Constants.durationAnimation
            circularProgressAnimation.toValue = progress
            circularProgressAnimation.fromValue = circleProgressLayer.strokeEnd
            circularProgressAnimation.fillMode = .forwards
            circularProgressAnimation.isRemovedOnCompletion = false
            
            circleProgressLayer.strokeEnd = progress
            circleProgressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        } else {
            circleProgressLayer.strokeEnd = progress
        }
    }
    
    // MARK: - Private
    
    private func addLayers() {
        layer.insertSublayer(circleLayer, at: 0)
        layer.insertSublayer(circleProgressLayer, at: 0)
        
        // Нужно, чтобы была видна иконка
        guard let imageView = imageView else { return }
        bringSubviewToFront(imageView)
    }
    
}
