//
//  CenterView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit

class CenterView: BaseView {
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "center_hea")
        return headImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "center_icon")
        return logoImageView
    }()
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.text = UserDefaults.standard.object(forKey: "phone") as? String ?? ""
        mlabel.textColor = UIColor.white
        mlabel.textAlignment = .left
        mlabel.font = UIFont.boldSystemFont(ofSize: 14)
        return mlabel
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "center_one")
        return oneImageView
    }()
    
    lazy var cenFootView: UIView = {
        let cenFootView = UIView()
        cenFootView.layer.cornerRadius = 9
        cenFootView.layer.masksToBounds = true
        cenFootView.backgroundColor = UIColor.init(hexStr: "#FFE266")
        return cenFootView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "center_two")
        return twoImageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "center_three")
        return threeImageView
    }()

    lazy var fourImageView: UIImageView = {
        let fourImageView = UIImageView()
        fourImageView.image = UIImage(named: "center_four")
        return fourImageView
    }()
    
    lazy var fiveImageView: UIImageView = {
        let fiveImageView = UIImageView()
        fiveImageView.image = UIImage(named: "center_five")
        return fiveImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.width.equalTo(screenwidth)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(308)
        }
        
        headImageView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        headImageView.addSubview(mlabel)
        mlabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.left.equalTo(logoImageView.snp.right)
            make.height.equalTo(20)
        }
        
        headImageView.addSubview(oneImageView)
        oneImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-52)
            make.size.equalTo(CGSize(width: 338, height: 54))
        }
        
        scrollView.addSubview(cenFootView)
        cenFootView.snp.makeConstraints { make in
            make.height.equalTo(567)
            make.centerX.equalToSuperview()
            make.width.equalTo(screenwidth)
            make.top.equalTo(oneImageView.snp.bottom)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        cenFootView.addSubview(twoImageView)
        cenFootView.addSubview(threeImageView)
        cenFootView.addSubview(fourImageView)
        cenFootView.addSubview(fiveImageView)
        
        
        twoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(31)
            make.left.equalToSuperview().offset(18)
            make.size.equalTo(CGSize(width: 165, height: 77))
        }
        
        threeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(31)
            make.right.equalToSuperview().offset(-18)
            make.size.equalTo(CGSize(width: 165, height: 77))
        }
        
        fourImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(threeImageView.snp.bottom).offset(18)
            make.size.equalTo(CGSize(width: 360, height: 125))
        }
        
        fiveImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(fourImageView.snp.bottom).offset(18)
            make.size.equalTo(CGSize(width: 360, height: 81))
        }
    }
    
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
