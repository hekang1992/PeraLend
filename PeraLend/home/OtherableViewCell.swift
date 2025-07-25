//
//  OtherableViewCell.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/24.
//

import UIKit

class OtherableViewCell: UITableViewCell {
    
    var model: nemaModel? {
        didSet {
            guard let model = model else { return }
            logoImageView.kf.setImage(with: URL(string: model.apertaster ?? ""))
            nameLabel.text = model.ruptwise ?? ""
            descLabel.text = model.theyine ?? ""
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
        nextBtn.setBackgroundImage(UIImage(named: "apply_imag_d"), for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return nextBtn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(moneyLabel)
        contentView.addSubview(nextBtn)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(18)
            make.height.equalTo(72)
            make.bottom.equalToSuperview().offset(-13)
        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
