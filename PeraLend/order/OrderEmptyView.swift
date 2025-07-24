//
//  OrderEmptyView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/24.
//

import UIKit
import RxSwift

class OrderEmptyView: UIView {
    
    var clickBlock: (() -> Void)?
    
    let disposeBag = DisposeBag()

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "backim_ho_d")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 164, height: 195))
            make.center.equalToSuperview()
        }
        
        bgImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHANGEROOTPAGE"), object: nil)
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
