//
//  CenterView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit

class CenterView: BaseView {
    
    var oneBlock: (() -> Void)?
    var twoBlock: (() -> Void)?
    var threeBlock: (() -> Void)?
    var fourBlock: (() -> Void)?
    var fiveBlock: (() -> Void)?
    var sixBlock: (() -> Void)?
    var sevenBlock: (() -> Void)?
    var eightBlock: (() -> Void)?
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "center_hea")
        headImageView.isUserInteractionEnabled = true
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
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = UserDefaults.standard.object(forKey: "phone") as? String ?? ""
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return nameLabel
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "center_one")
        oneImageView.isUserInteractionEnabled = true
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
        twoImageView.isUserInteractionEnabled = true
        return twoImageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "center_three")
        threeImageView.isUserInteractionEnabled = true
        return threeImageView
    }()

    lazy var fourImageView: UIImageView = {
        let fourImageView = UIImageView()
        fourImageView.image = UIImage(named: "center_four")
        fourImageView.isUserInteractionEnabled = true
        return fourImageView
    }()
    
    lazy var fiveImageView: UIImageView = {
        let fiveImageView = UIImageView()
        fiveImageView.image = UIImage(named: "center_five")
        fiveImageView.isUserInteractionEnabled = true
        return fiveImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton()
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton()
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton()
        return threeBtn
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton()
        return fourBtn
    }()
    
    lazy var fiveBtn: UIButton = {
        let fiveBtn = UIButton()
        return fiveBtn
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
        
        headImageView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
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
        
        fourImageView.addSubview(oneBtn)
        fourImageView.addSubview(twoBtn)
        fourImageView.addSubview(threeBtn)
        
        fiveImageView.addSubview(fourBtn)
        fiveImageView.addSubview(fiveBtn)
        
        oneBtn.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(120)
        }
        twoBtn.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(oneBtn.snp.right)
            make.width.equalTo(120)
        }
        threeBtn.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(120)
        }
        
        fourBtn.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(40)
        }
        fiveBtn.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        oneImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.oneBlock?()
        }).disposed(by: disposeBag)
        
        twoImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.twoBlock?()
        }).disposed(by: disposeBag)
        
        threeImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.threeBlock?()
        }).disposed(by: disposeBag)
        
        oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.fourBlock?()
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.fiveBlock?()
        }).disposed(by: disposeBag)
        
        threeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.sixBlock?()
        }).disposed(by: disposeBag)
        
        fourBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.sevenBlock?()
        }).disposed(by: disposeBag)
        
        fiveBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.eightBlock?()
        }).disposed(by: disposeBag)
        
    }
    
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
