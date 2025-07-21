//
//  CommonTabBarViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    private let customTabBar = CustomTabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupCustomTabBar()
    }
    
    private func setupViewControllers() {
        let homeVC = HomeViewController()
        let homeNav = BaseNavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem()
        
        let centerVC = CenterViewController()
        let centerNav = BaseNavigationController(rootViewController: centerVC)
        centerNav.tabBarItem = UITabBarItem()
        
        viewControllers = [homeNav, centerNav]
    }
    
    private func setupCustomTabBar() {
        tabBar.isHidden = true
        
        view.addSubview(customTabBar)
        customTabBar.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(80)
        }
        
        customTabBar.buttonTapped = { [weak self] index in
            self?.selectedIndex = index
            self?.customTabBar.setSelected(index: index)
        }
    }
    
    // 防止用户通过代码切换 selectedIndex 不触发 UI 同步
    override var selectedIndex: Int {
        didSet {
            customTabBar.setSelected(index: selectedIndex)
        }
    }
}


class CustomTabBarView: UIView {
    
    var buttonTapped: ((Int) -> Void)?
    
    private let stackView = UIStackView()
    private let bgImageView = UIImageView()
    private var buttons: [UIButton] = []
    private var selectedIndex: Int = 0
    
    private let iconNames = ["home", "center"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setSelected(index: 0) // 默认选中第一个
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setSelected(index: 0)
    }
    
    private func setupView() {
        backgroundColor = .clear
        bgImageView.image = UIImage(named: "tabbar_image")
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        for (index, name) in iconNames.enumerated() {
            let btn = UIButton(type: .custom)
            btn.tag = index
            btn.setImage(UIImage(named: "\(name)_nor"), for: .normal)
            btn.adjustsImageWhenHighlighted = false
            btn.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(btn)
            buttons.append(btn)
        }
    }
    
    @objc private func tabTapped(_ sender: UIButton) {
        setSelected(index: sender.tag)
        buttonTapped?(sender.tag)
    }
    
    public func setSelected(index: Int) {
        guard index < buttons.count else { return }
        for (i, btn) in buttons.enumerated() {
            let iconPrefix = iconNames[i]
            let imageName = (i == index) ? "\(iconPrefix)_sel" : "\(iconPrefix)_nor"
            btn.setImage(UIImage(named: imageName), for: .normal)
        }
        selectedIndex = index
    }
}
