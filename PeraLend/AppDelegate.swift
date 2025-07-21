//
//  AppDelegate.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        jianpanConfig()
        
        getNotifaction()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = LaunchViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
}


extension AppDelegate {
    
    private func jianpanConfig() {
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
    }
    
    private func getNotifaction() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(changeRootVc(_:)),
            name: NSNotification.Name("CHANGEROOTPAGE"),
            object: nil
        )
    }
    
    @objc func changeRootVc(_ noti: Notification) {
        if islogin {
            window?.rootViewController = CustomTabBarController()
        }else {
            window?.rootViewController = BaseNavigationController(rootViewController: LoginViewController())
        }
    }
    
    
}
