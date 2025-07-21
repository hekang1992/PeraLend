//
//  PhoneListView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit

class PhoneListView: UIView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 9
        return bgView
    }()
    
    lazy var listImageView: UIImageView = {
        let listImageView = UIImageView()
        listImageView.image = UIImage(named: "phone_im")
        return listImageView
    }()
    
    lazy var sendImageView: UIImageView = {
        let sendImageView = UIImageView()
        sendImageView.image = UIImage(named: "senige_sd")
        sendImageView.isUserInteractionEnabled = true
        return sendImageView
    }()
    
    lazy var sendBtn: UIButton = {
        let sendBtn = UIButton(type: .custom)
        sendBtn.setTitle("Send", for: .normal)
        sendBtn.setTitleColor(.white, for: .normal)
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return sendBtn
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        phoneTx.placeholder = "Please enter"
        phoneTx.font = UIFont.systemFont(ofSize: 14)
        phoneTx.textColor = UIColor.black
        return phoneTx
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        addSubview(listImageView)
        addSubview(sendImageView)
        sendImageView.addSubview(sendBtn)
        bgView.addSubview(phoneTx)
        bgView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 275, height: 70))
            make.center.equalToSuperview()
        }
        listImageView.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.top).offset(5)
            make.size.equalTo(CGSize(width: 184, height: 31))
            make.left.equalTo(listImageView.snp.left).offset(-8)
        }
        sendImageView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 75, height: 40))
        }
        phoneTx.snp.makeConstraints { make in
            make.top.equalTo(listImageView.snp.bottom)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(8)
            make.right.equalTo(sendImageView.snp.left).offset(-5)
        }
        sendBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
