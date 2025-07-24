//
//  PopLogoutView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit
import RxSwift

class PopLogoutView: UIView {
    
    let disposed = DisposeBag()
    
    var dismissblock: (() -> Void)?
    var sureblock: (() -> Void)?
    
    lazy var plendImageView: UIImageView = {
        let plendImageView = UIImageView()
        plendImageView.isUserInteractionEnabled = true
        return plendImageView
    }()

    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        return threeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(plendImageView)
        plendImageView.addSubview(oneBtn)
        plendImageView.addSubview(twoBtn)
        plendImageView.addSubview(threeBtn)
        plendImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 314, height: 345))
        }
        oneBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        twoBtn.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 155, height: 50))
        }
        threeBtn.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 155, height: 50))
        }
        
        oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismissblock?()
        }).disposed(by: disposed)
        
        threeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismissblock?()
        }).disposed(by: disposed)
        
        twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.sureblock?()
        }).disposed(by: disposed)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
