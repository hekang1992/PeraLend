//
//  hud.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/21.
//

import UIKit

class HudView: UIView {
    
    lazy var hudView: UIActivityIndicatorView = {
        let hudView = UIActivityIndicatorView(style: .large)
        hudView.backgroundColor = .white
        hudView.layer.cornerRadius = 9
        hudView.layer.masksToBounds = true
        hudView.startAnimating()
        return hudView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(hudView)
        hudView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
}

class ViewHud {
    
    static let loadView = HudView()
    
    static func hideLoadView() {
        DispatchQueue.main.async {
            loadView.removeFromSuperview()
        }
    }
    
    static func addLoadView() {
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.windows.first {
                DispatchQueue.main.async {
                    loadView.frame = keyWindow.bounds
                    keyWindow.addSubview(loadView)
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 90) {
            ViewHud.hideLoadView()
        }
    }
    
}
