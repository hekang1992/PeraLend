//
//  PhotoFaceListView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/22.
//

import UIKit
import RxSwift

class PhotoFaceListView: UIView {
    
    let disposed = DisposeBag()
    
    var clickblock: ((String) -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 9
        bgView.backgroundColor = UIColor.init(hexStr: "#FB7E09")
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 13)
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "image_ri_daf")
        return iconImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(iconImageView)
        
        bgView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 302, height: 36))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(18)
            make.height.equalTo(20)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        bgView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            self?.clickblock?(self?.nameLabel.text ?? "")
        }).disposed(by: disposed)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
