//
//  HeadView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit
import RxSwift

class HeadView: UIView {
    
    let disposed = DisposeBag()
    
    var backBlock: (() -> Void)?
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "backimage_cep"), for: .normal)
        return backBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hexStr: "#925500")
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return nameLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(backBtn)
        addSubview(nameLabel)
        
        backBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(280)
        }
        
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.backBlock?()
        }).disposed(by: disposed)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
