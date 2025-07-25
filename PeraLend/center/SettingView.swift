//
//  SettingView.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/21.
//

import UIKit

class SettingView: BaseView {
    
    
    var twoBlock: (() -> Void)?
    var threeBlock: (() -> Void)?
    var fourBlock: (() -> Void)?
    var fiveBlock: (() -> Void)?
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "set_one")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "set_two")
        twoImageView.isUserInteractionEnabled = true
        return twoImageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "set_three")
        threeImageView.isUserInteractionEnabled = true
        return threeImageView
    }()
    
    lazy var fourImageView: UIImageView = {
        let fourImageView = UIImageView()
        fourImageView.image = UIImage(named: "set_four")
        fourImageView.isUserInteractionEnabled = true
        return fourImageView
    }()
    
    lazy var fiveImageView: UIImageView = {
        let fiveImageView = UIImageView()
        fiveImageView.image = UIImage(named: "set_five")
        fiveImageView.isUserInteractionEnabled = true
        return fiveImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 9
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(oneImageView)
        addSubview(bgView)
        bgView.addSubview(twoImageView)
        bgView.addSubview(threeImageView)
        bgView.addSubview(fourImageView)
        bgView.addSubview(fiveImageView)
        
        oneImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 338, height: 89))
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        bgView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 338, height: 500))
            make.centerX.equalToSuperview()
            make.top.equalTo(oneImageView.snp.bottom)
        }
        twoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 303, height: 36))
        }
        threeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(twoImageView.snp.bottom).offset(11)
            make.size.equalTo(CGSize(width: 303, height: 36))
        }
        fourImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 235, height: 48))
            make.centerX.equalToSuperview()
            make.top.equalTo(threeImageView.snp.bottom).offset(45)
        }
        fiveImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 235, height: 48))
            make.centerX.equalToSuperview()
            make.top.equalTo(fourImageView.snp.bottom).offset(22)
        }
        
        twoImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.twoBlock?()
        }).disposed(by: disposeBag)
        
        threeImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.threeBlock?()
        }).disposed(by: disposeBag)
        
        fourImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.fourBlock?()
        }).disposed(by: disposeBag)
        
        fiveImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.fiveBlock?()
        }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
