//
//  OrderView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/24.
//

import UIKit

class OrderView: BaseView {
    
    var oneblock: (() -> Void)?
    var twoblock: (() -> Void)?
    var threeblock: (() -> Void)?
    var fourblock: (() -> Void)?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setImage(UIImage(named: "or_all_nor"), for: .normal)
        oneBtn.setImage(UIImage(named: "or_all_sel"), for: .selected)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setImage(UIImage(named: "or_und_nor"), for: .normal)
        twoBtn.setImage(UIImage(named: "or_und_sel"), for: .selected)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.setImage(UIImage(named: "or_pay_nor"), for: .normal)
        threeBtn.setImage(UIImage(named: "or_pay_sel"), for: .selected)
        return threeBtn
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        fourBtn.setImage(UIImage(named: "or_fin_nor"), for: .normal)
        fourBtn.setImage(UIImage(named: "or_fin_sel"), for: .selected)
        return fourBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(oneBtn)
        scrollView.addSubview(twoBtn)
        scrollView.addSubview(threeBtn)
        scrollView.addSubview(fourBtn)
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        oneBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 90, height: 28))
            make.centerY.equalToSuperview()
        }
        twoBtn.snp.makeConstraints { make in
            make.left.equalTo(oneBtn.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 90, height: 28))
            make.centerY.equalToSuperview()
        }
        threeBtn.snp.makeConstraints { make in
            make.left.equalTo(twoBtn.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 90, height: 28))
            make.centerY.equalToSuperview()
        }
        fourBtn.snp.makeConstraints { make in
            make.left.equalTo(threeBtn.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 90, height: 28))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        
        oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.oneblock?()
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.twoblock?()
        }).disposed(by: disposeBag)
        
        threeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.threeblock?()
        }).disposed(by: disposeBag)
        
        fourBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.fourblock?()
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
