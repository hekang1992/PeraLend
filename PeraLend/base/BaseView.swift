//
//  BaseView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit

class BaseView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


extension UIView {
    /// 给 UIView 添加渐变色
    /// - Parameters:
    ///   - colors: 渐变色数组（支持 CGColor 或 UIColor）
    ///   - startPoint: 起始点（默认从上到下）
    ///   - endPoint: 结束点
    ///   - cornerRadius: 圆角（可选）
    func addGradient(
        colors: [Any],
        startPoint: CGPoint = CGPoint(x: 0.5, y: 0),
        endPoint: CGPoint = CGPoint(x: 0.5, y: 1),
        cornerRadius: CGFloat = 0
    ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.cornerRadius = cornerRadius
        
        // 移除之前的渐变色
        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
