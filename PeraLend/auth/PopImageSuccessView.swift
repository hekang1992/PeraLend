//
//  PopImageSuccessView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/22.
//

import UIKit
import RxSwift

class PopImageSuccessView: UIView {
    
    let disposeBag = DisposeBag()
    
    var dismissBlock: (() -> Void)?
    var sureBlock: (() -> Void)?
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "head_image_ad")
        return bgImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 60
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var innerView: UIView = {
        let innerView = UIView()
        innerView.backgroundColor = .init(hexStr: "#FFF2BC")
        innerView.layer.cornerRadius = 60
        innerView.layer.masksToBounds = true
        return innerView
    }()
    
    lazy var footImageView: UIImageView = {
        let footImageView = UIImageView()
        footImageView.image = UIImage(named: "footp_do_imge")
        footImageView.isUserInteractionEnabled = true
        return footImageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        titleLabel.text = "Confirm The Information"
        return titleLabel
    }()
    
    lazy var nameView: AuthListNormalView = {
        let nameView = AuthListNormalView()
        nameView.namelabel.text = "Name"
        return nameView
    }()
    
    lazy var numberView: AuthListNormalView = {
        let numberView = AuthListNormalView()
        numberView.namelabel.text = "Id Number"
        return numberView
    }()
    
    lazy var dateView: AuthListEnumView = {
        let dateView = AuthListEnumView()
        dateView.namelabel.text = "Date of Birth"
        return dateView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(innerView)
        addSubview(bgImageView)
        
        bgImageView.addSubview(titleLabel)
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(130)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 302, height: 360))
        }
        innerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 15, bottom: 40, right: 15))
        }
        bgImageView.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.top).offset(-105)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 258, height: 157))
        }
        addSubview(footImageView)
        footImageView.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(-60)
            make.size.equalTo(CGSize(width: 302, height: 121))
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(20)
        }
        
        footImageView.addSubview(oneBtn)
        footImageView.addSubview(twoBtn)
        
        oneBtn.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(37)
        }
        
        twoBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(oneBtn.snp.top)
            make.height.equalTo(80)
        }
        
        oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismissBlock?()
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.sureBlock?()
        }).disposed(by: disposeBag)
        
        innerView.addSubview(scrollView)
        scrollView.addSubview(nameView)
        scrollView.addSubview(numberView)
        scrollView.addSubview(dateView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        nameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.size.equalTo(CGSize(width: 250, height: 80))
            make.centerX.equalToSuperview()
        }
        
        numberView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 250, height: 80))
            make.centerX.equalToSuperview()
        }
        
        dateView.snp.makeConstraints { make in
            make.top.equalTo(numberView.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 250, height: 80))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
