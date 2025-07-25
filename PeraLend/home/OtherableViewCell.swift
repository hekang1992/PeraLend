//
//  OtherableViewCell.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/24.
//

import UIKit
import RxSwift

class OtherableViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var clickBlock: (() -> Void)?
    
    var model: nemaModel? {
        didSet {
            guard let model = model else { return }
            logoImageView.kf.setImage(with: URL(string: model.apertaster ?? ""))
            nameLabel.text = model.ruptwise ?? ""
            descLabel.text = (model.theyine ?? "") + ":"
            moneyLabel.text = model.voluntacy ?? ""
            let title = model.amongel ?? ""
            if title.isEmpty {
                nextBtn.isHidden = true
            }else {
                nextBtn.isHidden = false
            }
            nextBtn.setTitle(title, for: .normal)
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 9
        bgView.backgroundColor = UIColor.init(hexStr: "#FFE265")?.withAlphaComponent(0.24)
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 18
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = .init(hexStr: "#666666")
        descLabel.font = UIFont.boldSystemFont(ofSize: 13)
        descLabel.textAlignment = .left
        return descLabel
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textColor = .init(hexStr: "#666666")
        moneyLabel.font = UIFont.boldSystemFont(ofSize: 13)
        moneyLabel.textAlignment = .right
        return moneyLabel
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setBackgroundImage(UIImage(named: "fads+__fa_fa"), for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        nextBtn.layer.cornerRadius = 9
        nextBtn.layer.masksToBounds = true
        return nextBtn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(descLabel)
        bgView.addSubview(moneyLabel)
        bgView.addSubview(nextBtn)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(18)
            make.height.equalTo(72)
            make.bottom.equalToSuperview().offset(-13)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(18)
            make.size.equalTo(CGSize(width: 36, height: 36))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(11)
            make.top.equalToSuperview().offset(18)
            make.height.equalTo(16)
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(11)
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.height.equalTo(16)
        }
        
        nextBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 88, height: 36))
        }
        moneyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(descLabel.snp.centerY)
            make.height.equalTo(16)
            make.left.equalTo(descLabel.snp.right).offset(5)
            make.right.equalTo(nextBtn.snp.left).offset(-10)
        }
        
        nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.clickBlock?()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
