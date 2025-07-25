//
//  OrderTableViewCell.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/24.
//

import UIKit
import RxSwift

class OrderTableViewCell: UITableViewCell {
    
    var btnBlock: (() -> Void)?
    
    let disposeBag = DisposeBag()
    
    var model: rurModel? {
        didSet {
            guard let model = model else { return }
            let productLogoUrl = model.sesquireallyment?.apertaster ?? ""
            logoImageView.kf.setImage(with: URL(string: productLogoUrl))
            namelabel.text = model.sesquireallyment?.ruptwise ?? ""
            oneLabel.text = model.sesquireallyment?.subteraceous ?? ""
            twoLabel.text = model.sesquireallyment?.introism ?? ""
            threeLabel.text = model.sesquireallyment?.photitor ?? ""
            fourLabel.text = model.sesquireallyment?.odorship ?? ""
            descLabel.text = model.sesquireallyment?.jointure ?? ""
            let beforeress = model.sesquireallyment?.beforeress ?? ""
            nextBtn.setTitle(model.sesquireallyment?.beforeress ?? "", for: .normal)
            if beforeress.isEmpty {
                nextBtn.isHidden = true
                bgImageView.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalToSuperview()
                    make.size.equalTo(CGSize(width: 340, height: 182))
                    make.bottom.equalToSuperview().offset(-15)
                }
            }else {
                nextBtn.isHidden = false
                bgImageView.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalToSuperview()
                    make.size.equalTo(CGSize(width: 340, height: 182))
                    make.bottom.equalToSuperview().offset(-60)
                }
            }
            let diaconditionry = model.sesquireallyment?.diaconditionry ?? 0
            if diaconditionry == 1 {
                bgImageView.image = UIImage(named: "overviewimage")
            }else if diaconditionry == 2 {
                bgImageView.image = UIImage(named: "applyimage")
            }else if diaconditionry == 3 {
                bgImageView.image = UIImage(named: "repaymentimage")
            }else if diaconditionry == 4 {
                bgImageView.image = UIImage(named: "underwayimage")
            }else if diaconditionry == 5 {
                bgImageView.image = UIImage(named: "finishaimage")
            }
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.textColor = UIColor.init(hexStr: "#FFFAE6")
        namelabel.textAlignment = .left
        namelabel.font = UIFont.boldSystemFont(ofSize: 12)
        return namelabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.font = UIFont.boldSystemFont(ofSize: 12)
        oneLabel.textColor = UIColor.init(hexStr: "#FFFAE6")
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .right
        twoLabel.font = UIFont.boldSystemFont(ofSize: 12)
        twoLabel.textColor = UIColor.init(hexStr: "#FFFAE6")
        return twoLabel
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textAlignment = .left
        threeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        threeLabel.textColor = UIColor.init(hexStr: "#FFFAE6")
        return threeLabel
    }()
    
    lazy var fourLabel: UILabel = {
        let fourLabel = UILabel()
        fourLabel.textAlignment = .right
        fourLabel.font = UIFont.boldSystemFont(ofSize: 12)
        fourLabel.textColor = UIColor.init(hexStr: "#FFFAE6")
        return fourLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.textColor = UIColor.white
        descLabel.textAlignment = .center
        descLabel.font = UIFont.boldSystemFont(ofSize: 10)
        return descLabel
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
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(namelabel)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(threeLabel)
        bgImageView.addSubview(fourLabel)
        bgImageView.addSubview(descLabel)
        contentView.addSubview(nextBtn)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 340, height: 182))
            make.bottom.equalToSuperview().offset(-60)
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.left.equalToSuperview().offset(144)
            make.size.equalTo(CGSize(width: 31, height: 31))
        }
        namelabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.height.equalTo(15)
            make.left.equalTo(logoImageView.snp.right).offset(8)
        }
        oneLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(140)
            make.top.equalTo(logoImageView.snp.bottom).offset(15)
            make.height.equalTo(14)
        }
        twoLabel.snp.makeConstraints { make in
            make.left.equalTo(oneLabel.snp.right).offset(12)
            make.centerY.equalTo(oneLabel.snp.centerY)
            make.height.equalTo(14)
        }
        threeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(140)
            make.top.equalTo(oneLabel.snp.bottom).offset(8)
            make.height.equalTo(14)
        }
        fourLabel.snp.makeConstraints { make in
            make.left.equalTo(threeLabel.snp.right).offset(12)
            make.centerY.equalTo(threeLabel.snp.centerY)
            make.height.equalTo(14)
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(threeLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(44)
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 235, height: 49))
            make.top.equalTo(bgImageView.snp.bottom).offset(10)
        }
        
        nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.btnBlock?()
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
