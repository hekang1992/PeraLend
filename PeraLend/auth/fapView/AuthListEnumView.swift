//
//  AuthListEnumView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/22.
//

import UIKit
import RxSwift

class AuthListEnumView: UIView {
    
    let disposeBag = DisposeBag()
    
    var clickblock: ((UITextField) -> Void)?

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "lis_auy_uu")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.textColor = UIColor.init(hexStr: "#F2CC42")
        namelabel.textAlignment = .left
        namelabel.font = UIFont.boldSystemFont(ofSize: 12)
        return namelabel
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.placeholder = "Please Enter"
        phoneTx.font = UIFont.boldSystemFont(ofSize: 12)
        phoneTx.textColor = .black
        phoneTx.isEnabled = false
        return phoneTx
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(namelabel)
        bgImageView.addSubview(phoneTx)
        bgImageView.addSubview(oneBtn)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 243, height: 76))
        }
        namelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.left.equalToSuperview().offset(14)
            make.height.equalTo(14)
        }
        phoneTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        oneBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.clickblock?(phoneTx)
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
