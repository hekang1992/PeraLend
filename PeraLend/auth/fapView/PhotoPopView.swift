//
//  PhotoPopView.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/21.
//

import UIKit
import RxSwift

class PhotoPopView: UIView {
    
    let disposed = DisposeBag()
    
    var dismissblock: (() -> Void)?
    var photoblock: (() -> Void)?
    var camerablock: (() -> Void)?
    
    lazy var plendImageView: UIImageView = {
        let plendImageView = UIImageView()
        plendImageView.isUserInteractionEnabled = true
        plendImageView.image = UIImage(named: "umad_ima_da")
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
            make.size.equalTo(CGSize(width: 302, height: 466))
        }
        oneBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
            make.size.equalTo(CGSize(width: 150, height: 40))
        }
        
        twoBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
            make.size.equalTo(CGSize(width: 150, height: 40))
        }
        
        threeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.photoblock?()
        }).disposed(by: disposed)
        
        twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.camerablock?()
        }).disposed(by: disposed)
        
        
        threeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismissblock?()
        }).disposed(by: disposed)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class CameraPopView: UIView {
    
    let disposed = DisposeBag()
    
    var dismissblock: (() -> Void)?
    var camerablock: (() -> Void)?
    
    lazy var plendImageView: UIImageView = {
        let plendImageView = UIImageView()
        plendImageView.isUserInteractionEnabled = true
        plendImageView.image = UIImage(named: "face_iamg_ad_d")
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(plendImageView)
        plendImageView.addSubview(oneBtn)
        plendImageView.addSubview(twoBtn)
        plendImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 302, height: 466))
        }
        oneBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
            make.size.equalTo(CGSize(width: 235, height: 40))
        }
        
        twoBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 150, height: 40))
        }
        
        oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.camerablock?()
        }).disposed(by: disposed)
        
        twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismissblock?()
        }).disposed(by: disposed)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
