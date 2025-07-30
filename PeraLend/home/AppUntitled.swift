//
//  Untitled.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/30.
//

import UIKit

class ShowPermissionAlert{
   static func showPermissionAlert(from vc: UIViewController, feature: String) {
        let alert = UIAlertController(
            title: "\(feature) Permission Disabled",
            message: "Please go to Settings > Privacy > \(feature) to enable the permission and try again.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))
        
        vc.present(alert, animated: true)
    }
}
