//
//  BaseNavigationController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationBar.isHidden = true
        self.navigationBar.isTranslucent = false
        self.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == viewControllers.first {
            (tabBarController as? CustomTabBarController)?.setCustomTabBar(hidden: false)
        } else {
            (tabBarController as? CustomTabBarController)?.setCustomTabBar(hidden: true)
        }
    }
    
}
